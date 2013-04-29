class AddFriendsIndex < ActiveRecord::Migration
  def self.up
		add_index :friends, [:user_id, :user_id_friend], :unique => true
  end

	def self.down
		remove_index :friends, [:user_id, :user_id_friend]
	end
end
