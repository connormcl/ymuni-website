class User < ActiveRecord::Base
	has_one :app
	before_save { self.email = email.downcase }
	validates :first_name, presence: true, length: { maximum: 25 }
	validates :last_name, presence: true, length: { maximum: 25 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
	has_secure_password
	validates :password, length: { minimum: 6 }, allow_blank: true
end
