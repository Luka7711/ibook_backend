class BookController < ApplicationController
	get '/' do
		erb :book_index
	end
end	