class InviteController < ApplicationController

  def new
  end

  def create
    # @user = current_user
    # handle
    # mailer
    # binding.pry
    flash[:success] = "Successfully sent invite!"
    redirect_to dashboard_path
  end

end
