class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :password, :password_confirmation, :user_name
	
	validates :user_name, presence: true, uniqueness:true
	validates :first_name, presence: true
	validates :last_name, presence: true
	has_secure_password
end
