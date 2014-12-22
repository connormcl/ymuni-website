class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    	#login and redirect to app_form page
    	log_in user
    	flash[:success] = "Welcome back, #{current_user.first_name}"
    	redirect_back_or root_path
    else
    	#display error message
    	flash.now[:danger] = "Invalid email/password combination"
		  render 'new'
    end
  end

  def destroy
  	log_out @current_user
    flash[:success] = "Logout successful"
  	redirect_to root_path
  end
end
