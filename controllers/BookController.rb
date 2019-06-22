class BookController < ApplicationController

	# redirect to home page
	get '/' do
		@user = User.find_by ({:username => session[:username]})
		# book_all = Book.all
		@books = Book.all.sort
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
		book.title = params[:title].downcase
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

	# shos users unwanted books
	get '/profile' do
		# find a user
		user = User.find_by ({:username => session[:username]})
		# find a list of unwanted books
		@unwanted_books = Book.where :user_id => user.id
		if @unwanted_books.length == 0
			session[:book_status] = "There is no books in your library"	
		else
			session[:book_status] = " "
		end
		erb :profile_show
	end

	# delete a book 
	delete '/unwantedList/:id' do
		book = Book.find params[:id]
		#find a comment related with current book
		comment = Comment.find_by ({:book_for_exchange_id => book[:id]})
		# comment = Comment.find 23
		if comment
		 comment.destroy
		 book.destroy
		 redirect '/ibook/profile'
		else
		 book.destroy
		 redirect '/ibook/profile'
		end
	end

	# shows edit form
	get '/unwantedList/edit/:id' do
		@book = Book.find params[:id]
		@category = Category.all
		erb :book_edit
	end

	# update edits of book
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

	# shows all offering books
	# show all messages
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
	# user able to send an offer
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
		comment.time_date = Time.new
		comment.save
		redirect '/ibook'

	end
	
	# see actual offer from other user
	# 2 books 
	get '/showDeal/:id' do
		# pass current comment 
		@comment = Comment.find params[:id]
		@current_user_book = Book.find @comment[:book_for_exchange_id]
		@offering_book = Book.find @comment[:book_offered_id]
		user2 = User.find_by({:id => @comment[:from_id]}) 
		city_name = user2[:city]
		found_state = State.find_by({:id => user2[:state_code]})
		
		puts 
		pp "found state is:"
		pp found_state
		state = found_state[:code]

		puts
		pp city_name
		pp state

		def address(city_name, state)
			arr_city = city_name.split(' ')
			if arr_city.length > 1
				arr_city = arr_city.join('+')
				return arr_city + ',' + state
			elsif arr_city.length == 1  
				return  arr_city[0] + ',' + state
			end
		end	
		@modified = address(city_name, state)
		@other_user = user2[:username][0]
		erb :show_deal
	end

	put '/deal/:id' do 
		# find a 
		# transition
		# find an other user id
		#user 1
		current_user = User.find_by({:username => session[:username]})
		data = Comment.find params[:id]
		# book1
		my_book = Book.find_by({:id => data[:book_for_exchange_id]})
		# .where :user_id => data[:book_for_exchange_id]
		# book2
		offered_book = Book.find_by({:id => data[:book_offered_id]})
		# Book.where :user_id => data[:book_offered_id]
		#user 2
		offered_book.user_id = data[:user_id]
		offered_book.save
		my_book.user_id  = data[:from_id]
		my_book.save

		# comment = Comment.find params[:id]
		comment = Comment.where :book_for_exchange_id => data[:book_for_exchange_id]
		comment2 = Comment.where :book_offered_id => data[:book_offered_id]
		puts
		pp 'comments to do delete'
		pp comment
		comment.each do |item|
			item.destroy
		end
		comment2.each do |item2|
			item2.destroy
		end
		redirect '/ibook'
	end

	# reject offer
	delete '/deal/:id' do
		comment = Comment.find params[:id]
		comment.destroy
		redirect '/ibook'
	end
	#show specific book
	get '/category/:id' do
		@books = Book.where :category_id => params[:id]
		erb :category_items
	end

	get '/about' do
		erb :about
	end
	# find one book, and display it
	get '/:id' do
		@book = Book.find params[:id]
		erb :book_show
	end

	get '/search/book/find' do
		@books = Book.where :title => params[:search].downcase

		if @books.length != 0
			session[:search_result] = ""
			erb :search_results
		elsif 
			session[:search_result] = "Sorry, there is no such a book in our library"
			redirect '/ibook'
		end	
	end

end	