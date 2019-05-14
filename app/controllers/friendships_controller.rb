class FriendshipsController < ApplicationController

  def create
    if new_friend = User.find_by(git_id: params[:git_id])
      create_friends(new_friend)
      flash[:success] = "#{new_friend.first_name} added as a friend!"
    else
      flash[:invalid] = "Invalid user id"
    end
    redirect_to dashboard_path
  end


  private

    def create_friends(new_friend)
      Friendship.create(user_id: current_user.id, friend_id: new_friend.id)
      Friendship.create(user_id: new_friend.id, friend_id: current_user.id)
    end

end
