class Applicant < User
	has_one :app
	belongs_to :recommender
	mount_uploader :resume, ResumeUploader
end
