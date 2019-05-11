class UsersController < ApplicationController
  def show
    render locals: {
      facade: GithubFacade.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Email already taken'
      render :new
    end
  end

  def update
    current_user.update(git_key: updated_token)
    flash[:connected] = "Connected to Github!"
    redirect_to dashboard_path
  end


  private

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password)
    end

    def auth_hash
      request.env['omniauth.auth']
    end

    def updated_token
      auth_hash["credentials"]["token"]
    end

end
