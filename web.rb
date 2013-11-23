ENV['BUNDLE_GEMFILE'] = File.expand_path('Gemfile', File.dirname(__FILE__))

RACK_ENV ||= ENV["RACK_ENV"] || "development"

require 'bundler/setup'
require 'sinatra'
require "sinatra/reloader" if development?


get '/' do
	send_file File.expand_path('index.html', settings.public_folder)
end

get '/ping' do
	"SP rocks!"
end
