class ApplicantsController < ApplicationController
	def new
		@applicant = Applicant.new
	end

	def create
		@applicant = Applicant.new(applicant_params)
		if @applicant.save
			flash.now[:success] = "New applicant successfully created!"
			redirect_to @applicant
		else
			render 'new'
		end
	end

	def show
		@applicant = Applicant.find(params[:id])
	end

	def index
		@applicants = Applicant.all
	end

	private
		def applicant_params
			params.require(:applicant).permit(:name, :email, :password, :password_confirmation)
		end
end
