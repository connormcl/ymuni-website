class SessionsController < ApplicationController
  def new
  end

  def create
  	applicant = Applicant.find_by(email: params[:session][:email].downcase)
    if applicant && applicant.authenticate(params[:session][:password])
    	#login and redirect to app_form page
    	log_in applicant
    	redirect_to applicant
    else
    	#display error message
    	flash.now[:error] = 'Invalid email/password combination'
		render 'new'
	end
  end

  def destroy
  	log_out @current_applicant
  	redirect_to root_path
  end
end
