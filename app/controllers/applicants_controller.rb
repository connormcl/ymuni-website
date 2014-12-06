class ApplicantsController < ApplicationController
	def new
	end

	def create
		@applicant = Applicant.new(applicant_params)
		#@applicant = Applicant.new(params[:applicant])

		@applicant.save
		redirect_to @applicant
		#redirect_to applicants_path
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
