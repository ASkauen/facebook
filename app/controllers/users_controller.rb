class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @friendship = Friendship.find_by(friend_a: current_user, friend_b: @user) || Friendship.find_by(friend_a: @user, friend_b: current_user)
    @friend_request = FriendRequest.find_by(sender: current_user, recipient: @user) || FriendRequest.find_by(sender: @user, recipient: current_user)
  end

  def update_avatar
    user = User.find(params[:id])
    user.update(avatar: update_params[:avatar])
  end

  private

  def update_params
    params.require(:user).permit([:avatar, :id])
  end
end
