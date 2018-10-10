class UserMailer < ApplicationMailer
  default from: 'propertymanagement.atv@gmail.com'

  def welcome_email(email)
    @user = "Tushar"
    @url  = 'http://example.com/login'
    mail(to: email, subject: 'Welcome to My Awesome Site')
  end
end
