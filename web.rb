ENV['BUNDLE_GEMFILE'] = File.expand_path('Gemfile', File.dirname(__FILE__))

RACK_ENV ||= ENV["RACK_ENV"] || "development"

require 'bundler/setup'
require 'sinatra'
require "sinatra/reloader" if development?
require 'base64'
require 'aws/s3'
include AWS::S3

get '/' do
	send_file File.expand_path('index.html', settings.public_folder)
end

post '/upload_tile' do
	decoded_image = Base64.decode64(params['imgBase64'])

	AWS::S3::DEFAULT_HOST.replace('s3-ap-southeast-1.amazonaws.com') 

	AWS::S3::Base.establish_connection!(
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    )

    S3Object.store("#{Time.now.to_f}.png", decoded_image, ENV['S3_BUCKET'],
                   access: :public_read)
end

get '/ping' do
	"SP rocks!"
end
