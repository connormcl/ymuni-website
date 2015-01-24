class App < ActiveRecord::Base
	belongs_to :applicant

	attr_accessor :page

	validates :first_name, presence: true, length: { maximum: 25 }, :if => :page_one?
	validates :middle_name, length: { maximum: 25 }, :if => :page_one?
	validates :last_name, presence: true, length: { maximum: 25 }, :if => :page_one?
	validates :address, presence: true, length: { maximum: 125 }, :if => :page_one?
	validates :city, presence: true, length: { maximum: 50 }, :if => :page_one?
	validates :state, presence: true, length: { maximum: 25 }, :if => :page_one?
	validates :zip_code, presence: true, length: { maximum: 10 }, :if => :page_one?
	validates :country, presence: true, length: {maximum: 50}, :if => :page_one?
	# validates :date_of_birth #, presence: true, length: {maximum: 50}, :if => :page_one?


	validates :ethnicity, presence: true, length: {maximum: 25}, :if => :page_one?
	validates :school_name, presence: true, length: {maximum: 50}, :if => :page_one?
	validates :school_address, presence: true, length: {maximum: 125}, :if => :page_one?
	validates :school_city, presence: true, length: {maximum: 50}, :if => :page_one?
	validates :school_state, presence: true, length: {maximum: 25}, :if => :page_one?
	validates :school_zip_code, presence: true, length: {maximum: 10}, :if => :page_one?
	validates :school_country, presence: true, length: {maximum: 50}, :if => :page_one?
	# validates :grade_level #, presence: true, length: {maximum: 50}, :if => :page_one?
	#validates :email, presence: true, length: {maximum: 50}
	VALID_PHONE_REGEX = /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/
	validates :phone_number, presence: true, length: {maximum: 50}, format: { with: VALID_PHONE_REGEX}, :if => :page_one?
	validates :personal_statement, :length => {
	    :minimum   => 0,
	    :maximum   => 750,
	    :tokenizer => lambda { |str| str.split(" ") },
	    :too_short => "must have at least %{count} words",
	    :too_long  => "cannot have more than %{count} words"
  	}, :if => :page_two?
	validates :supplemental_question_1, :length => {
	    :minimum   => 0,
	    :maximum   => 500,
	    :tokenizer => lambda { |str| str.split(" ") },
	    :too_short => "must have at least %{count} words",
	    :too_long  => "cannot have more than %{count} words"
  	}, :if => :page_two?
  	validates :supplemental_question_2, :length => {
	    :minimum   => 0,
	    :maximum   => 500,
	    :tokenizer => lambda { |str| str.split(" ") },
	    :too_short => "must have at least %{count} words",
	    :too_long  => "cannot have more than %{count} words"
  	}, :if => :page_two?
  	validates :supplemental_question_3, :length => {
	    :minimum   => 0,
	    :maximum   => 500,
	    :tokenizer => lambda { |str| str.split(" ") },
	    :too_short => "must have at least %{count} words",
	    :too_long  => "cannot have more than %{count} words"
  	}, :if => :page_two?
  	validates :supplemental_question_4, :length => {
	    :minimum   => 0,
	    :maximum   => 500,
	    :tokenizer => lambda { |str| str.split(" ") },
	    :too_short => "must have at least %{count} words",
	    :too_long  => "cannot have more than %{count} words"
  	}, :if => :page_two?
  	validates :supplemental_question_5, :length => {
	    :minimum   => 0,
	    :maximum   => 500,
	    :tokenizer => lambda { |str| str.split(" ") },
	    :too_short => "must have at least %{count} words",
	    :too_long  => "cannot have more than %{count} words"
  	}, :if => :page_two?
	# validates :supplemental_question_2, length: {maximum: 500}, :if => :page_two?   #, length: {in: 250..500}
	# validates :supplemental_question_3, length: {maximum: 500}, :if => :page_two?   #, length: {in: 250..500}
	# validates :supplemental_question_4, length: {maximum: 500}, :if => :page_two?   #, length: {in: 250..500}
	# validates :supplemental_question_5, length: {maximum: 500}, :if => :page_two?   #, length: {in: 250..500}

	# validate :supplemental_question_1_word_count, :supplemental_question_2_word_count, :supplemental_question_3_word_count,
	# 		 :supplemental_question_4_word_count, :supplemental_question_5_word_count, :if => :page_two?

	validates :gpa, allow_blank: true, numericality: { only_integer: false, greater_than_or_equal_to: 0, less_than_or_equal_to: 4.0 }, :if => :page_five?
	validates :sat_score, allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 200, less_than_or_equal_to: 2400 }, :if => :page_five?
	validates :act_score, allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 36 }, :if => :page_five?
	validates :toefl_score, allow_blank: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 120 }, :if => :page_five?

	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	#validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
	#has_secure_password
	#validates :password, length: { minimum: 6 }, allow_blank: true

	def page_one?
		page == '1' || page == "1" || page == 1
	end

	def page_two?
		page == '2' || page == "2" || page == 2
	end

	def page_five?
		page == '5' || page == "5" || page == 5
	end

	def personal_statement_word_count
		if personal_statement.split(" ").length > 50
			errors.add(:personal_statement, "must be 750 words or less")
		end
	end

	def supplemental_question_1_word_count
		if supplemental_question_1.split(" ").length > 500
			errors.add(:supplemental_question_1, "must be 500 words or less")
		end
	end

	def supplemental_question_2_word_count
		if supplemental_question_2.split(" ").length > 500
			errors.add(:supplemental_question_2, "must be 500 words or less")
		end
	end

	def supplemental_question_3_word_count
		if supplemental_question_3.split(" ").length > 500
			errors.add(:supplemental_question_3, "must be 500 words or less")
		end
	end

	def supplemental_question_4_word_count
		if supplemental_question_4.split(" ").length > 500
			errors.add(:supplemental_question_4, "must be 500 words or less")
		end
	end

	def supplemental_question_5_word_count
		if supplemental_question_5.split(" ").length > 500
			errors.add(:supplemental_question_5, "must be 500 words or less")
		end
	end
end
