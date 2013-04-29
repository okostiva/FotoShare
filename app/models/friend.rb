class Friend < ActiveRecord::Base
	belongs_to :user

	belongs_to :accepted_friends, :foreign_key => 'user_id_friend', :class_name => 'User'
	belongs_to :pending_friends, :foreign_key => 'user_id_friend', :class_name => 'User'

  attr_accessible :confirmed, :user_id, :user_id_friend
end
