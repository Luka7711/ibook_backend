require 'sinatra/base'

# Controllers
require './controllers/ApplicationController'
require './controllers/UserController'
require './controllers/BookController'

# MODELS
require './models/UserModel'
require './models/BookModel'
require './models/CategoryModel'
require './models/CommentModel'
require './models/StateModel'


map ('/'){
	run ApplicationController
}

map ('/auth'){
	run UserController
}

map ('/ibook'){
	run BookController
}
