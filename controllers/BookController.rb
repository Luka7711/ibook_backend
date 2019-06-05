class BookController < ApplicationController

	# redirect to home page
	get '/' do
		@user = User.find_by ({:username => session[:username]})
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

	delete '/unwantedList/:id' do
		book = Book.find params[:id]
		book.destroy
		redirect '/ibook/profile'
	end

	get '/unwantedList/edit/:id' do
		@book = Book.find params[:id]
		@category = Category.all
		erb :book_edit
	end

	put '/unwantedList/:id' do
		book = Book.find params[:id]
		book.title = params[:title]
		book.author = params[:author]
		book.published_year = params[:year]
		book.description = params[:description]
		book.image = params[:image]
		book.category_id = params[:category].to_i
		book.save

		@book_title = book[:title]
		redirect '/ibook/profile'
	end

	# shows all offered books
	# show all comments
	get '/offers/:id' do
		# get all books except the ones user owns
		# find an user who wrote an comment
		@book = Book.select do |book| book.user_id != params[:id].to_i end
		comment = Comment.where :user_id => params[:id]
		if comment 
		 @comments = comment
		 erb :book_offer_show
		else
			erb :book_offer_show
		end
	end

	#shows for where user can send offer to
	# owner of the book
	get '/owner/:id' do
	# find a current user
	# find all available books current user has
	# find an owner of offered book by id
		@user = User.find_by ({:username => session[:username]})
		@my_books = Book.where :user_id => @user[:id]
		@other_user_book = Book.find params[:id]
		@owner_of_book = User.find @other_user_book[:user_id].to_i
	# find an existing comments	
		erb :single_offer
	end

	# id of the book other user
	post '/owner/:id' do
		# find an user who owns the book
		other_user_book = Book.find params[:id] 
		other_user_id = other_user_book[:user_id]
		

		other_user = User.find other_user_book[:user_id]
		current_user = User.find_by({:username => session[:username]})

		comment = Comment.new
		comment.comment_for = params[:comment]
		comment.user_id = other_user_id
		comment.from_id = current_user[:id]
		comment.book_for_exchange_id = other_user_book[:id]
		comment.book_offered_id = params[:book]
		comment.sender_name = current_user[:username]
		comment.save
		redirect '/ibook'

	end
	# params[:id] is id of from_id 
	get '/showDeal/:id' do
		# pass current comment 
		@comment = Comment.find params[:id]
		@current_user_book = Book.find @comment[:book_for_exchange_id]
		@offering_book = Book.find @comment[:book_offered_id]
		erb :show_deal
	end

	delete '/deal/:id' do
		comment = Comment.find params[:id]
		comment.destroy
		redirect '/ibook'
	end
end	