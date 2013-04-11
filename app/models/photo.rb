class Photo < ActiveRecord::Base
	belongs_to :user

  attr_accessible :user_id, :caption
end
