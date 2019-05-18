class ActivateController < ApplicationController

  def show

  end

  def create
    if current_user.email == params[:email]
      current_user.update(role: 'active')
      render :show
    end
  end


end
