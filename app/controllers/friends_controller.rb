class FriendsController < ApplicationController
  # GET /friends
  # GET /friends.json
  def index
    @accepted_friends = @logged_in_user.accepted_friends
    @pending_friends = @logged_in_user.pending_friends
    @friend_requests = @logged_in_user.friend_requests

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logged_in_user.accepted_friends }
    end
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
		redirect_to @logged_in_user.friends.find(params[:id])
  end

  # GET /friends/new
  # GET /friends/new.json
  def new
    @friend = Friend.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @friend }
    end
  end

  # GET /friends/1/edit
  def edit
    @friend = Friend.find(params[:id])
  end

  # POST /friends
  # POST /friends.json
  def create
    @friend = Friend.new
		@friend.user_id = @logged_in_user.id
		@friend.user_id_friend = params[:friend_id]
		@friend.confirmed = false

    respond_to do |format|
      if @friend.user_id == @friend.user_id_friend
        format.html { redirect_to friends_path, :flash => { :alert => 'You cannot request yourself as a friend.' } }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
			elsif @friend.save
        format.html { redirect_to friends_path, notice: 'Friend was successfully created.' }
        format.json { render json: friends_path, status: :created, location: friends_path }
      else
        format.html { redirect_to friends_path, :flash => { :alert => 'Unable to add friend. Please try again later.' } }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /friends/1
  # PUT /friends/1.json
  def update
    @friend = Friend.find(params[:id])
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
    @friend = Friend.where(:user_id_friend => @logged_in_user.id, :user_id => params[:friend_id]).first
		@friendship = Friend.where(:user_id_friend => params[:friend_id], :user_id => @logged_in_user.id).first

    @friend.destroy
		@friendship.destroy

    respond_to do |format|
      format.html { redirect_to friends_url, notice: 'Friend successfully removed.' }
      format.json { head :no_content }
    end
  end

  # GET /confirm
  def confirm
    @friend = Friend.where(:user_id_friend => @logged_in_user.id, :user_id => params[:friend_id]).first
		@friend.confirmed = true

		@friendship = Friend.new
		@friendship.user_id = @friend.user_id_friend
		@friendship.user_id_friend = @friend.user_id
		@friendship.confirmed = true

    respond_to do |format|
      if (params[:approve] == "true") && @friend.update_attributes(:confirmed => true) && @friendship.save
        format.html { redirect_to friends_path, notice: 'Friend request approved.' }
        format.json { head :no_content }
			elsif (params[:approve] == "false") && @friend.destroy
        format.html { redirect_to friends_path, notice: 'Friend request rejected.' }
        format.json { head :no_content }
      else
        format.html { redirect_to friends_path, :flash => { :alert => "Unable to modify friend. Please try again later." } }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end
end
