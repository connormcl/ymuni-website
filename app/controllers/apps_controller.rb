class AppsController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update, :show, :index]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: [:index, :destroy, :show]
	before_action :submitted, only: [:edit, :update]
	before_action :not_submitted, only: [:status]

	def show
		@user = Applicant.find(params[:applicant_id])
		@app = @user.app
	end

	def edit
		@user = current_user #User.find(params[:id])
		@app = @user.app
		if params[:page] == '2'
			render 'edit-2'
		elsif params[:page] == '3'
			@recommender = Recommender.new
			if Recommender.find_by(:id => @user.recommender_id) != nil
				@recommender = Recommender.find_by(:id => @user.recommender_id)
			else
				@recommender = Recommender.new
			end
			render 'edit-3'
		elsif params[:page] == '4'
			render 'edit-4'
		elsif params[:page] == '5'
			render 'edit-5'
		elsif params[:page] == '6'
			render 'edit-6'
		elsif params[:page] == '7'
			render 'edit-7'
		end
	end

	def status
		@user = current_user
		@app = @user.app
	end

	def submit
		@user = current_user
		@app = @user.app

		@app.submitted = true
		@app.save

		flash[:success] = "Application submitted! Congrats."
		redirect_to root_path
	end

	def update
		@user = current_user
		@app = @user.app
		@app.page = params[:page]
		
		if @app.update_attributes(app_params)
			if params[:app][:resume]
				uploaded_io = params[:app][:resume]
				#File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
				#File.open(Rails.root.join('public', 'uploads', "#{params[:user_id]}.#{params[:id]}resume"), 'wb') do |file|
				#directory_name = "/public/uploads/#{params[:user_id]}"
				#Dir.mkdir(directory_name) unless File.exists?(directory_name)
				File.open(Rails.root.join('public', 'uploads', "#{params[:user_id]}", "#{params[:user_id]}-#{uploaded_io.original_filename}"), 'wb') do |file|
  					file.write(uploaded_io.read)
  				end
  			end
			flash[:success] = "Application updated"
			#redirect_to edit_user_app_path(current_user, current_user.app)
			#redirect_to edit_user_app_path(current_user, current_user.app, params.merge(:page => params[:page]))
			#redirect_to :back
		end

		if params[:page] == '2'
			render 'edit-2'
		elsif params[:page] == '3'
			render 'edit-3'
		elsif params[:page] == '4'
			render 'edit-4'
		elsif params[:page] == '5'
			render 'edit-5'
		elsif params[:page] == '6'
			render 'edit-6'
		elsif params[:page] == '7'
			render 'edit-7'
		else
			render 'edit'
		end
	end

	private
		def app_params
			params.require(:app).permit(:first_name, :middle_name, :last_name, :address, :city, :state, :zip_code, :country, :date_of_birth, 
				:ethnicity, :school_name, :school_address, :school_city, :school_state, :school_zip_code, :school_country, :grade_level, :email, :phone_number,
				:personal_statement, :supplemental_question_1, :supplemental_question_2, :supplemental_question_3, :supplemental_question_4,
				:supplemental_question_5, :gpa, :sat_score, :act_score, :toefl_score, :recommender_email, :additional_comments)
		end

		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "Please log in."
				redirect_to login_path
			end
		end

		def correct_user
			@user = User.find(params[:applicant_id])
			redirect_to root_path unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end

		def submitted
			if current_user.app.submitted?
				redirect_to(root_path)
			end
		end

		def not_submitted
			unless current_user.app.submitted?
				redirect_to(root_path)
			end
		end
end
