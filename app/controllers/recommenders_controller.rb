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

		if Recommender.find_by({:email => params[:recommender][:email]}) == nil
			@recommender = Recommender.new(recommender_params)
			o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
			random_password = (0...8).map { o[rand(o.length)] }.join
			@recommender.password = random_password
			@recommender.password_confirmation = random_password

			if @recommender.save
				#new stuff
				@recommender.applicants << @applicant

				UserMailer.recommender_email(@recommender, @applicant).deliver
				flash[:success] = "Invitation email sent to recommender"
			else
				flash[:danger] = "Invalid email address"
			end
		else
			@recommender = Recommender.find_by(:email => params[:recommender][:email])
			if @recommender.id != @applicant.recommender_id
				@recommender.applicants << @applicant
				UserMailer.recommender_email(@recommender, @applicant).deliver
				flash[:success] = "Invitation email sent to recommender"
			else
				flash[:danger] = "You have already invited this recommender"
			end
		end
		redirect_to edit_applicant_app_path(current_user, current_user.app, params.merge(:page => '3'))
	end


	private
		def recommender_params
			params.require(:recommender).permit(:email, :first_name, :last_name, :password, :password_confirmation, :applicant_id)
		end
end
