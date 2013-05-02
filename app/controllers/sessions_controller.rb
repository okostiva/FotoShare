class SessionsController < ApplicationController
	skip_before_filter :authorize
	before_filter :create_joke

  def new
  end

  def create
		user = User.find_by_user_name(params[:user_name])
		if user and user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to user
		else
			redirect_to login_path, alert: "Invalid username/password combination."
		end
  end

  def destroy
		session[:user_id] = nil
		redirect_to login_path, notice: "Successfully logged out."
  end

	def create_joke
		jokes = Joke.find(:all, :from => "/jokes")
		index = Random.new.rand(jokes.count)

		@joke = jokes[index]
	end
end
