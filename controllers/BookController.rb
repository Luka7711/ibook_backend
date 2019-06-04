class BookController < ApplicationController

	# redirect to home page
	get '/' do
		@books = Book.all
		@category = Category.all
		erb :book_index
	end

	# redirect to create form
	get '/new' do
		@category = Category.all
		erb :book_new
	end

	# creating a book
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

	get '/profile' do
		# find a user
		user = User.find_by ({:username => session[:username]})
		# find a list of unwanted books
		@unwanted_books = Book.where :user_id => user.id
		erb :profile_show
	end
end	