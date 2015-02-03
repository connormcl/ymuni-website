class UserMailer < ActionMailer::Base
  default from: "tech.ymuni@yira.org"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Yale Model United Nations Institute')
  end

  def recommender_email(recommender, applicant)
  	@applicant = applicant
  	@recommender = recommender
  	mail(to: @recommender.email, subject: 'Yale Model United Nations Institute Recommendation')
  end

end
