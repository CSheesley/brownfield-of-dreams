class ActivationMailer < ApplicationMailer

  def activate(user)
    @user = user
    mail(to: @user.email, subject: "#{@user.first_name}, activate your account.")
  end
end
