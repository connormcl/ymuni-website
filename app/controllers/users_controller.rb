class UsersController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update, :show, :index]
	before_action :correct_user, only: [:edit, :update, :show]
	before_action :admin_user, only: [:index, :destroy]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
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

	def show
		@user = User.find(params[:id])
	end

	def index
		@users = User.all
	end

	def destroy
		User.find(params[:id]).destroy
    	flash[:success] = "User deleted"
    	redirect_to users_path
    end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			redirect_to root_path
		else
			render 'edit'
		end
	end

	def reset_password_form
	end

	def reset_password
		#email = params[:email]
		@user = User.find_by({:email => params[:user][:email]})
		if @user != nil
			o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
			random_password = (0...8).map { o[rand(o.length)] }.join
			@user.update_attributes({:password => random_password, :password_confirmation => random_password})
			#@user.password = random_password
			#@user.password_confirmation = random_password

			UserMailer.reset_password_email(@user).deliver
			flash[:success] = "Password reset email sent"
		else
			flash[:danger] = "Invalid email address"
		end

		redirect_to users_reset_password_path
	end

	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
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
