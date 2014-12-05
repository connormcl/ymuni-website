class ApplicantsController < ApplicationController
	def new
	end

	def create
		@applicant = Applicant.new(applicant_params)

		@applicant.save
		redirect_to @applicant
	end

	def show
		@applicant = Applicant.find(params[:id])
	end

	def index
		@applicants = Applicant.all
	end

	private
		def applicant_params
			params.require(:applicant).permit(:name, :email)
		end
end
