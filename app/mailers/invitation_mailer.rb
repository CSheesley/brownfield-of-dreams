class InvitationMailer < ApplicationMailer

  def invite(user, handle, email)
    @user = user
    @handle = handle
    @email = email
    mail(to: @email, subject: "#{@handle} - join our awesome app!")
  end
end
