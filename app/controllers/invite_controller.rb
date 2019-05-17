class InviteController < ApplicationController

  def new
  end

  def create
    @user = current_user
    @handle = params[:handle]

    if git_hub_email(@handle)
      # send email
      flash[:success] = "Successfully sent invite!"
    else
      flash[:failure] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end

  private

    def git_hub_email(handle)
      @_handle_email = service.get_email(handle)
    end

    def service
      @_service = GithubService.new(@user, @handle)
    end
end
