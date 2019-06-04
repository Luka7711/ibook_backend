class BookController < ApplicationController
	get '/' do
		@category = Category.all
		erb :book_index
	end
end	