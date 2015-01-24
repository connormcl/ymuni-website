class User < ActiveRecord::Base
	attr_accessor :page

	before_save { self.email = email.downcase }
	validates :first_name, presence: true, length: { maximum: 25 }#, :if => :page_not_three?
	validates :last_name, presence: true, length: { maximum: 25 }#, :if => :page_not_three?
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
	has_secure_password#, :if => :page_not_three?
	validates :password, length: { minimum: 6 }, allow_blank: true#, :if => :page_not_three?


	def page_not_three?
		page != '3' && page != "3" && page != 3
	end
end
