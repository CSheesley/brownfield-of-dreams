class InviteController < ApplicationController

  def new
  end

  def create
    @user = current_user

    if get_email(params[:handle])
      # send email
      flash[:success] = "Successfully sent invite!"
    else
      flash[:failure] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end

  private

    def get_email(handle)
      conn = Faraday.new("https://api.github.com/users/") do |f|
        f.headers["Authorization"] = "TOKEN #{@user.git_key}"
        f.adapter Faraday.default_adapter
      end
      response = conn.get(handle)

      email = JSON.parse(response.body, symbolize_name: true)["email"]

    end

    # def conn
    #   # service = service.new()
    # end
end
