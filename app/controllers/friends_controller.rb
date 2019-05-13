class FriendsController < ApplicationController

  def create
    new_friend = User.find_by(git_id: params[:git_id])
    require 'pry'; binding.pry

  end

end