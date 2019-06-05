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
		@books = Book.where :user_id => @user[:id]
		other_user_book = Book.find params[:id]
		@owner_of_book = User.find other_user_book[:user_id].to_i
	# find an existing comments	
		erb :single_offer
	end

	post '/owner/:id' do
		# find an owner of the book
		user = User.find params[:id]
		# FROM saving an id of current that sends an offer
		current_user = User.find_by({:username => session[:username]})
		# create new comment
		comment = Comment.new
		# assing user id to comment table
		comment.comment_for = params[:comment]
		# TO saving an id of user that owns book
		comment.user_id = user[:id] 
		comment.book_id = params[:book]
		comment.from_id = current_user[:id]
		# save it
		comment.save
		redirect '/ibook'
	end

	# params[:id] is id of from_id 
	get '/showDeal/:id' do
		# find a book that being exchanging
		# find a book that been offered
		# create accept/reject btns
		
		erb :show_deal
	end
end	