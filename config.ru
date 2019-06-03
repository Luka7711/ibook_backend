require 'sinatra/base'

# Controllers
require './controllers/ApplicationController'
require './controllers/UserController'


# MODELS
require './models/UserModel'
require './models/BookModel'
require './models/CategoryModel'
require './models/CommentModel'


map ('/'){
	run ApplicationController
}

map ('/auth'){
	run UserController
}
