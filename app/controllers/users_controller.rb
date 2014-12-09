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
			log_in @user
			flash.now[:success] = "New user successfully created!"
			redirect_to @user
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
			redirect_to @user
		else
			render 'edit'
		end
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
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