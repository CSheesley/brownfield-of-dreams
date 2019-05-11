class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    #does not have access to email to find user by
    #need to find another way to find or create by

    #does have access to auth_hash
  
    user = User.find_by(email: params[:session][:email])
    # if user.git_key.nil?
    #   user.update(git_key: params["authenticity_token"])
    #   redirect_to dashboard_path
    # else
    #
    # end

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = "Looks like your email or password is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

private

    def auth_hash
      request.env['omniauth.auth']
    end

end
