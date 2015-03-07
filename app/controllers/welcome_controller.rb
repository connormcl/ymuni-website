class WelcomeController < ApplicationController
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
end
