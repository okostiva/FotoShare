class ApplicationController < ActionController::Base
  protect_from_forgery

	before_filter :authorize, :load_current_user

	protected
		def authorize
			unless User.find_by_id(session[:user_id])
				redirect_to login_path, notice: "Please log in to access that."
			end
		end

		def load_current_user
			@logged_in_user = User.find_by_id(session[:user_id])
		end
end
