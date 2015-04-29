class ApplicantsController < ApplicationController
	before_action :admin_user, only: [:index, :destroy]
	
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
			UserMailer.welcome_email(@user, @app).deliver
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
		@user = Applicant.find(params[:id])
	end

	def email_all
		@applicants = Applicant.all
		@applicants.each do |applicant|
			UserMailer.all_applicants_email(applicant, params[:applicant][:title],
				params[:applicant][:message]).deliver
		end
		flash[:success] = "Email sent to all applicants!"
		redirect_to admin_panel_path
	end

	DOWNLOAD_PATH = File.join(Rails.root, "public")

	def show_resume
		@applicant = Applicant.find(params[:applicant_id])
		send_file(Rails.root.join(@applicant.resume.path))
		#send_file(File.join(DOWNLOAD_PATH, "#{@applicant.resume.path}"))
		#send_file(@applicant.resume.path)
 	end

 	def show_recommendation
		@applicant = Applicant.find(params[:applicant_id])
		send_file(Rails.root.join(@applicant.recommendation.path))
		#send_file(File.join(DOWNLOAD_PATH, "#{@applicant.recommendation.path}"))
		#send_file(@applicant.recommendation.path)
 	end


	# def update
	# 	@user = Applicant.find(params[:id])
	# 	#@user.resume = params[:resume]
	# 	if @user.update_attributes(user_params)
	# 		if @user.resume != nil
	# 			flash[:success] = "Resume uploaded"
	# 		else
	# 			flash[:success] = "Profile updated"
	# 		end
	# 		redirect_to edit_applicant_app_path(current_user, current_user.app, :params => {:page => '4'})
	# 	else
	# 		render 'edit'
	# 	end
	# end

	# def update
	# 	@user = Applicant.find(params[:id])
	# 	#@user.resume = params[:resume]
	# 	if @user.update_attributes(user_params)
	# 		if @user.recommendation != nil
	# 			flash[:success] = "Recommendation uploaded"
	# 		else
	# 			flash[:success] = "Profile updated"
	# 		end
	# 		redirect_to recommender_dashboard_path
	# 	else
	# 		redirect_to recommender_dashboard_path
	# 	end
	# end

	def update
		@user = Applicant.find(params[:id])
		#@user.resume = params[:resume]
		if current_user.type == 'Applicant'
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
		else
			if @user.update_attributes(user_params)
				if @user.recommendation != nil
					flash[:success] = "Recommendation uploaded"	
				else
					flash[:danger] = "Failed to upload recommendation"
				end
			else
				flash[:danger] = "Failed to upload recommendation"
			end
			redirect_to recommender_dashboard_path
		end
	end

	# def index
	# 	@applicants = Applicant.order(:id)
	# end

	def index
		if params[:sort_dir] == 'true'
			@last_dir = true
		else
			@last_dir = false
		end
		if "#{params[:sort_param]}" != "submitted"
			# @applicants = Applicant.order("#{params[:sort_param]} #{params[:sort_dir]}")
			if @last_dir
				@applicants = Applicant.order("#{params[:sort_param]} ASC")
			else
				@applicants = Applicant.order("#{params[:sort_param]} DESC")
			end
		else
			all_applicants = Applicant.all
			submitted = Array.new
			unsubmitted = Array.new
			all_applicants.each do |a|
				if a.app.submitted
					submitted.push(a)
				else
					unsubmitted.push(a)
				end
			end
			if @last_dir
				(@applicants = submitted).flatten!
				(@applicants << unsubmitted).flatten!
			else
				(@applicants = unsubmitted).flatten!
				(@applicants << submitted).flatten!
			end
		end
	end

	def destroy
		Applicant.find(params[:id]).destroy
    	flash[:success] = "Applicant deleted"
    	redirect_to applicants_path
    end

	private
		def user_params
			params.require(:applicant).permit(:first_name, :last_name, :email, :password, :password_confirmation, :resume, :recommendation)
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
