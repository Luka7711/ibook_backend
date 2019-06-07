class User < ActiveRecord::Base
	has_secure_password
	has_many :comments
	has_many :books
	has_one :state
end