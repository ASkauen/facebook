class FriendshipsController < ApplicationController
  def destroy
    Friendship.find(params[:id]).destroy
    user = User.find(params[:user])
  end
end
