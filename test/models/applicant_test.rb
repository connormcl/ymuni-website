require 'test_helper'

class ApplicantTest < ActiveSupport::TestCase
	def setup
		@applicant = Applicant.new(name: "Connor", email: "connor.mclaughlin@yale.edu", password: "foobar", password_confirmation: "foobar")
	end

	test "should be valid" do
		assert @applicant.valid?
	end
  
    test "name should be valid" do
    	@applicant.name = "       "
    	assert_not @applicant.valid?
    end

    test "email should be valid" do
    	@applicant.email = "       "
    	assert_not @applicant.valid?
    end

    test "name should not be too long" do
    	@applicant.name = "a" * 51
    	assert_not @applicant.valid?
    end

    test "email should not be too long" do
    	@applicant.email = "a" * 256
    	assert_not @applicant.valid?
    end

    test "email validation should accept valid addresses" do
    	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    	valid_addresses.each do |valid_address|
      		@applicant.email = valid_address
      		assert @applicant.valid?, "#{valid_address.inspect} should be valid"
    	end
  	end

  	test "email validation should reject invalid addresses" do
    	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    	invalid_addresses.each do |invalid_address|
      		@applicant.email = invalid_address
      		assert_not @applicant.valid?, "#{invalid_address.inspect} should be invalid"
    	end
  	end

  	test "email addresses should be unique" do
    	duplicant_applicant = @applicant.dup
    	duplicant_applicant.email = @applicant.email.upcase
    	@applicant.save
    	assert_not duplicant_applicant.valid?
  	end

  	test "password should have a minimum length" do
    	@applicant.password = @applicant.password_confirmation = "a" * 5
    	assert_not @applicant.valid?
  	end
end
