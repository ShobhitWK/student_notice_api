class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email,subject:"Somebody just signed into your account.")
  end

  def new_registration(user)
    @user = user
    mail(to: @user.email,subject:"Welcome to Student Notice API")
  end
end
