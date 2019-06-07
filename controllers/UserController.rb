class UserController < ApplicationController

	#show sign up form
	get '/register' do 
		@states = State.all
		erb :register
	end

	post '/register' do
		user = User.find_by username: params[:username]

		if !user
		user = User.new
		 user.username = params[:username]
		 user.password = params[:password]
		 user.city = params[:city]
		 user.state_code = params[:state]
		 user.save

		 session[:logged_in] = true
		 session[:username] = user.username
		 session[:user_id] = user[:id]
		 # redirect '/ibook'
		redirect '/ibook'
		else 
		 session[:message] = {
		 	message: "Sorry username #{params[:username]} is already taken"
		 }
		 redirect '/auth/register'
		end
	end	

	get '/login' do
		erb :login
	end

	post '/login' do
		user = User.find_by username: params[:username]
		pw = params[:password]
		if user && pw
		 session[:logged_in] = true
		 session[:username] = user.username
		 session[:user_id] = user[:id]
		 session[:message] = {
		 	message: "Logged in as #{user.username}"
		 }
		 redirect '/ibook'	
		else 
		 session[:message] = {
		 	message: "wrong username or password"
		 }
		redirect '/auth/login'	
		end		
	end

	get '/logout' do
		session.destroy
		redirect '/ibook'
	end
end