class ApplicationController < Sinatra::Base

	require 'bundler'
	require 'date'
	Bundler.require()

	Dotenv.load

	require './config/environments'

	use Rack::Session::Cookie, 	:key => 'rack.session',
								:path => '/',
								:secret => ENV['SESSION_SECRET']

	# ActiveRecord::Base.establish_connection(
	# 	:adapter => 'postgresql',
	# 	:database => 'book_library'
	# )

	use Rack::MethodOverride
	set :method_override, true

	set :views, File.expand_path('../../views', __FILE__)
    set :public_dir, File.expand_path('../../public', __FILE__)

	get '/' do 
		redirect '/ibook'
	end

	get '/test' do
		binding.pry
		'hello world' 
	end

end