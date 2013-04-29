class User < ActiveRecord::Base
	has_many :photos, dependent: :destroy
	has_many :friends, dependent: :destroy

	has_many :a_friends, :class_name => 'Friend', :conditions => { :confirmed => true }
	has_many :p_friends, :class_name => 'Friend', :conditions => { :confirmed => false }
	has_many :accepted_friends, :through => :a_friends
	has_many :pending_friends, :through => :p_friends

	has_many :friend_requests, :class_name => 'User', :finder_sql => proc{"select users.* from users inner join friends on friends.user_id = users.id where friends.user_id_friend = #{id} and friends.user_id not in (select friends.user_id_friend from friends where friends.user_id = #{id})"}
#	has_many :friends_as_user_source, :foreign_key => 'user_id_friend', :class_name => 'Friend'
#	has_many :friends_as_user_friend, :foreign_key => 'user_id', :class_name => 'Friend', :conditions => { :confirmed => true }
#	has_many :user_sources, :through => :friends_as_user_source
#	has_many :friends, :through 

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
