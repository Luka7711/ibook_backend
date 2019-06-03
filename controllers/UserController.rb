class UserController < ApplicationController

	#show sign up form
	get '/register' do 
		erb :register
	end
end