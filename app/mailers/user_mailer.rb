class UserMailer < ApplicationMailer
  def welcome_email(email,user)
    @user = user
    mail(to: email,subject:"Somebody Signed into your account.")
  end

end

# ,body:"Hello #{user.name}!\n Looks like someone signed into your account, Check if it's you."
