class RecommendersController < ApplicationController
	def new
		@recommender = Recommender.new
	end

	def index_applicants
		@applicants = current_user.applicants
	end

	def create
		@applicant = current_user
		@app = @applicant.app
		@recommender = Recommender.new(recommender_params)
		# @recommender.first_name = "first_name"
		# @recommender.last_name = "last_name"
		o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
		random_password = (0...8).map { o[rand(o.length)] }.join
		@recommender.password = random_password
		@recommender.password_confirmation = random_password

		#@applicant.recommender_id = @recommender.id
		#@applicant.update_attributes(:recommender_id => @recommender.id)
		
		#@recommender.applicants << @applicant
		#@applicant.first_name
		#@applicant.recommender_id

		# @recommender.applicants.create(:recommender_id => @recommender.id)

		if @recommender.save
			#new stuff
			@recommender.applicants << @applicant

			#@recommender.applicants.create(:first_name => "jake")#(:recommender_id => @recommender.id)

			#@recommender.app = App.create( :first_name => @recommender.first_name )
			#@app = App.create( :first_name => @user.first_name )
			#@user.app = @app
			#log_in @user
			UserMailer.recommender_email(@recommender, @applicant).deliver
			flash[:success] = "Invitation email sent to recommender"
			redirect_to edit_applicant_app_path(current_user, current_user.app, params.merge(:page => '3'))
		else
			flash[:danger] = "Invalid email address"
			redirect_to edit_applicant_app_path(current_user, current_user.app, params.merge(:page => '3'))#'edit-3'
		end
	end


	private
		def recommender_params
			params.require(:recommender).permit(:email, :first_name, :last_name, :password, :password_confirmation, :applicant_id)
		end
end
