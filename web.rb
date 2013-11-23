require_relative File.join('config', "shared.rb")

get '/' do
	"hello world"
end

get '/ping' do
	"SP rocks!"
end
