class InviteController < ApplicationController
  def new; end

  def create
    @user = current_user
    @handle = params[:handle]
    @email = git_hub_email(@handle)

    if git_hub_email(@handle)
      InvitationMailer.invite(@user, @handle, @email).deliver_now
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:failure] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end

  private

  def git_hub_email(handle)
    @_handle_email ||= service.get_email(handle)
    # binding.pry
  end

  def service
    @_service ||= GithubService.new(@user, @handle)
  end
end
