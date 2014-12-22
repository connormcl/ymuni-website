class AppsController < ApplicationController
	def edit
		@user = current_user #User.find(params[:id])
		@app = @user.app
		if params[:page] == '2'
			render 'edit-2'
		elsif params[:page] == '3'
			render 'edit-3'
		end
			
	end

	def update
		@user = current_user
		@app = @user.app
		if @app.update_attributes(app_params)
			flash[:success] = "Application updated"
			#redirect_to edit_user_app_path(current_user, current_user.app)
			#redirect_to edit_user_app_path(current_user, current_user.app, params.merge(:page => params[:page]))
			redirect_to :back
		else
			render 'edit'
		end
	end

	private
		def app_params
			params.require(:app).permit(:first_name, :middle_name, :last_name, :address, :city, :state, :zip_code, :country, :date_of_birth, 
				:ethnicity, :school_name, :school_address, :school_city, :school_state, :school_country, :grade_level, :email, :phone_number,
				:personal_statement, :supplemental_question_1, :supplemental_question_2, :supplemental_question_3, :supplemental_question_4,
				:supplemental_question_5)
		end
end