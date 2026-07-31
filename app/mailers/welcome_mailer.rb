class WelcomeMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @app_name = "SocialCircle"
    
    mail to: @user.email, subject: "Welcome to #{@app_name}!"
  end
end