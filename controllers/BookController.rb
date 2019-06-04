class BookController < ApplicationController
	get '/' do
		@category = Category.all
		erb :book_index
	end

	get '/new' do
		@category = Category.all
		erb :book_new
	end

	post '/unwantedList' do 
		book = Book.new
		book.title = params[:title]
		book.author = params[:author]
		book.published_year = params[:year]
		book.description = params[:description]
		book.image = params[:image]
		user = User.find_by ({ :username => session[:username]})
		book.user_id = user.id
		book.category_id = params[:category].to_i
		book.save
		redirect '/ibook'
	end
end	