class Photo < ActiveRecord::Base
	belongs_to :user

  attr_accessible :user_id, :caption, :picture

	validates_attachment :picture, :presence => true,
		:content_type => { :content_type => ["image/jpg","image/jpeg","image/png","image/gif"], :message => "must be a jpg, png or gif image." }, 
		:size => { :in => 0..2.megabytes, :message => "must be less than 1 megabyte" }

	has_attached_file :picture, :path => "cs446/kostival/#{Rails.env}:url",
		:styles => { :small => "100x100>", :medium => "300x300>", :large => "500x500>" }, :default_url => "/images/photos/upload.png"
end
