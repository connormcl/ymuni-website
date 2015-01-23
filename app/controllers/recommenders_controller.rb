class RecommendersController < ApplicationController
	def new
		@recommender = Recommender.new
	end

	def create
		@user = current_user
		@app = @user.app
		@recommender = Recommender.new(recommender_params)
		@recommender.first_name = "connor"
		@recommender.last_name = "mclaughlin"
		@recommender.password = "connor"
		@recommender.password_confirmation = "connor"
		if @recommender.save
			#new stuff
			@recommender.apps << @app

			@recommender.app = App.create( :first_name => @recommender.first_name )
			#@app = App.create( :first_name => @user.first_name )
			#@user.app = @app
			#log_in @user
			UserMailer.welcome_email(@recommender).deliver
			flash[:success] = "Invitation email sent to recommender"
			redirect_to edit_user_app_path(current_user, current_user.app, params.merge(:page => '3'))
		else
			flash[:danger] = "Invalid email address"
			redirect_to edit_user_app_path(current_user, current_user.app, params.merge(:page => '3'))#'edit-3'
		end
	end


	private
		def recommender_params
			params.require(:recommender).permit(:email, :first_name, :last_name, :password, :password_confirmation)
		end
end
