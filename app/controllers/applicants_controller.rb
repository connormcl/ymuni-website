class ApplicantsController < ApplicationController
	def new
		@user = Applicant.new
	end

	def create
		@user = Applicant.new(user_params)
		if @user.save
			#new stuff
			@app = App.create( :first_name => @user.first_name )
			@user.app = @app
			log_in @user
			flash[:success] = "New user successfully created!"
			UserMailer.welcome_email(@user).deliver
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
		@user = Applicant.find(params[:id])
	end

	def update
		@user = Applicant.find(params[:id])
		#@user.resume = params[:resume]
		if @user.update_attributes(user_params)
			if @user.resume != nil
				flash[:success] = "Resume uploaded"
			else
				flash[:success] = "Profile updated"
			end
			redirect_to edit_applicant_app_path(current_user, current_user.app, :params => {:page => '4'})
		else
			render 'edit'
		end
	end

	def index
		@applicants = Applicant.all
	end

	def destroy
		Applicant.find(params[:id]).destroy
    	flash[:success] = "Applicant deleted"
    	redirect_to applicants_path
    end

	private
		def user_params
			params.require(:applicant).permit(:first_name, :last_name, :email, :password, :password_confirmation, :resume)
		end

		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "Please log in."
				redirect_to login_path
			end
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to root_path unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end
