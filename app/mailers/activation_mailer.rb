class ActivationMailer < ApplicationMailer

  def activate(user, user_email)
    @user = user
    mail(to: user_email, subject: "#{user.name}, activate your account.")
  end
end
