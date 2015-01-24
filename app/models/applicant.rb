class Applicant < User
	has_one :app
	belongs_to :recommender#, :foreign_key => "recommender_id"
end
