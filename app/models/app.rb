class App < ActiveRecord::Base
	belongs_to :user

	validates :first_name, presence: true, length: { maximum: 25 }
	validates :middle_name, length: { maximum: 25 }
	validates :last_name, presence: true, length: { maximum: 25 }
	validates :address, presence: true, length: { maximum: 125 }
	validates :city, presence: true, length: { maximum: 50 }
	validates :state, presence: true, length: { maximum: 25 }
	validates :zip_code, presence: true, length: { maximum: 10 }
	#validates_format_of :zip_code, :with => /^\d{5}(-\d{4})?$/, :message => "should be in the form 12345 or 12345-1234", :multiline => true
	validates :country, presence: true, length: {maximum: 50}
	validates :date_of_birth, presence: true #, length: {maximum: 50}


	validates :ethnicity, presence: true, length: {maximum: 25}
	validates :school_name, presence: true, length: {maximum: 50}
	validates :school_address, presence: true, length: {maximum: 125}
	validates :school_city, presence: true, length: {maximum: 50}
	validates :school_state, presence: true, length: {maximum: 25}
	validates :school_zip_code, presence: true, length: {maximum: 10}
	validates :school_country, presence: true, length: {maximum: 50}
	validates :grade_level, presence: true #, length: {maximum: 50}
	#validates :email, presence: true, length: {maximum: 50}
	VALID_PHONE_REGEX = /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/
	validates :phone_number, presence: true, length: {maximum: 50}, format: { with: VALID_PHONE_REGEX}
	#validates :personal_statement, presence: true, length: {in: 500..750}
	#validates :supplemental_question_1, presence: true, length: {in: 250..500}
	#validates :supplemental_question_2, presence: true, length: {in: 250..500}
	#validates :supplemental_question_3, presence: true, length: {in: 250..500}
	#validates :supplemental_question_4, presence: true, length: {in: 250..500}
	#validates :supplemental_question_5, presence: true, length: {in: 250..500}
	validates :gpa, numericality: { only_integer: false, greater_than_or_equal_to: 0, less_than_or_equal_to: 4.0 }
	validates :sat_score, allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 200, less_than_or_equal_to: 2400 }
	validates :act_score, allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 36 }
	validates :toefl_score, allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 120 }

	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	#validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
	#has_secure_password
	#validates :password, length: { minimum: 6 }, allow_blank: true
end
