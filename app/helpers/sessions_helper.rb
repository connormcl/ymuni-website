module SessionsHelper
	def log_in(user)
		session[:user_id] = user.id
	end

	def log_out(user)
		session.delete(:user_id)
		@current_user = nil
	end

	def current_user
		@current_user ||= User.find_by(id: session[:user_id])

		# if((@current_user != nil) && (@current_user.type == 'Applicant'))
		# 	@current_user ||= User.find_by(id: session[:user_id])
		# else
		# 	@current_user = nil
		# end

		# if((@current_user != nil) && (@current_user.type == 'Applicant'))
		# 	@current_user = Applicant.find_by(id: session[:user_id])
		# end
		if((@current_user != nil) && (@current_user.type == 'Applicant'))
			@current_user ||= Applicant.find_by(id: session[:user_id])
		else
			@current_user ||= User.find_by(id: session[:user_id])
		end
	end

	def current_user?(user)
		user == current_user
	end

	def logged_in?
		!current_user.nil?
	end

	def admin?
		current_user.admin?
	end

	# Redirects to stored location (or to the default).
  	def redirect_back_or(default)
    	redirect_to(session[:forwarding_url] || default)
    	session.delete(:forwarding_url)
  	end

  	# Stores the URL trying to be accessed.
  	def store_location
    	session[:forwarding_url] = request.url if request.get?
  	end
end
