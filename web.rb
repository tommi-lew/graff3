ENV['BUNDLE_GEMFILE'] = File.expand_path('Gemfile', File.dirname(__FILE__))

RACK_ENV ||= ENV["RACK_ENV"] || "development"

require 'bundler/setup'
require 'sinatra'
require "sinatra/reloader" if development?
require 'base64'
require 'aws/s3'
include AWS::S3
require "redis"

# Redis
if RACK_ENV != 'development'
	# production
	uri = URI.parse(ENV["REDISTOGO_URL"])
	redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
else
	redis = Redis.new
end

	
get '/' do
	send_file File.expand_path('index.html', settings.public_folder)
end

get '/canvas' do
	html = ""

	0.upto(4) do |row|
		0.upto(4) do |col|
			current_key = "#{row}-#{col}"

			current_tile = redis.hmget('c1', current_key)[0]

			src = "Graffcubed logo.png"

			if current_tile != nil
				src = ENV['S3_HOST'] + "/" +  current_tile
			end


			if (col == 0)
				html += '<div class="ui-block-a"><img src="'+ src +'" ></div>'
			elsif (col == 1)
				html += '<div class="ui-block-b"><img src="'+ src +'" ></div>'
			elsif (col == 2)
				html += '<div class="ui-block-c"><img src="'+ src +'" ></div>'
			elsif (col == 3)
				html += '<div class="ui-block-d"><img src="'+ src +'" ></div>'
			elsif (col == 4)
				html += '<div class="ui-block-e"><img src="'+ src +'" ></div>'
			end
			
		end
	end

	erb :'grid.html', :locals => {:grids => html}
end

post '/upload_tile' do
	decoded_image = Base64.decode64(params['imgBase64'])

	AWS::S3::DEFAULT_HOST.replace('s3-ap-southeast-1.amazonaws.com') 

	AWS::S3::Base.establish_connection!(
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    )

	aws_filename = "#{Time.now.to_f}.png";
    S3Object.store(aws_filename, decoded_image, ENV['S3_BUCKET'],
                   access: :public_read)

    # save file name into redis
	row = Random.new.rand(0..4) 
	col = Random.new.rand(0..4)
	pos = "#{row}-#{col}"
	redis.hmset('c1', pos, aws_filename)
end

get '/ping' do
	"SP rocks!"
end
