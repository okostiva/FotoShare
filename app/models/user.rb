class User < ActiveRecord::Base
	has_many :photos, dependent: :destroy

  attr_accessible :avatar, :first_name, :last_name, :password, :password_confirmation, :user_name
	
	validates :user_name, presence: true, uniqueness:true
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates_attachment :avatar, :content_type => { :content_type => ["image/jpg","image/jpeg","image/png","image/gif"], :message => "must be a jpg, png or gif image." }, 
		:size => { :in => 0..2.megabytes, :message => "must be less than 1 megabyte" }
	has_secure_password

	has_attached_file :avatar, :path => "cs446/kostival/#{Rails.env}:url",
		:styles => { :medium => "300x300>", :thumb => "100x100>", :mini => "40x40>" }, :default_url => "/images/avatars/default.png"
end
