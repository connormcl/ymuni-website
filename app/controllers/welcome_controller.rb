class WelcomeController < ApplicationController
	before_action :logged_in_user, only: [:admin_panel]
	before_action :admin_user, only: [:admin_panel]

	def about
	end

	def vision
	end

	def curriculum
	end

	def team
	end

	def dates
	end

	def financial
	end

	def faq
	end

	def apply
	end

	def join_our_team
	end

	def admin_panel
		@users = User.where(:admin => true)
	end

	private
		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end

		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "Please log in."
				redirect_to login_path
			end
		end
end
