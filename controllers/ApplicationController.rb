class ApplicationController < Sinatra::Base

	require 'bundler'

	Bundler.require()

	enable :sessions

	ActiveRecord::Base.establish_connection(
		:adapter => 'postgresql',
		:database => 'book_library'
	)

	use Rack::MethodOverride
	set :method_override, true

	set :views, File.expand_path('../../views', __FILE__)
	set :public_dir, File.expand_path('../../pubic', __FILE__)

	get '/' do 
		redirect '/ibook'
	end

	get '/test' do
		binding.pry
		'hello world' 
	end

end