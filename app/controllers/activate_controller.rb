class ActivateController < ApplicationController

  def show

  end

  def create
    # require 'pry'; binding.pry
    if current_user.email == params[:email]
      current_user.update(role: 'active')
      render :show
    end
  end


end

