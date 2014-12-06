module SessionsHelper
	def log_in(applicant)
		session[:applicant_id] = applicant.id
	end

	def log_out(applicant)
		session.delete(:applicant_id)
		@current_applicant = nil
	end

	def current_applicant
		@current_applicant ||= Applicant.find_by(id: session[:applicant_id])
	end

	def logged_in?
		!current_applicant.nil?
	end
end
