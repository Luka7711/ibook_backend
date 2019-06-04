class BookController < ApplicationController
	get '/' do
		@category = Category.all
		erb :book_index
	end

	get '/new' do
		@category = Category.all
		erb :book_new
	end
end	