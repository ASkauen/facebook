class FriendshipsController < ApplicationController
  def destroy
    Friendship.find(params[:id]).destroy
  end
end
