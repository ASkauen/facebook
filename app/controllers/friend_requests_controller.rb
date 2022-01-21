class FriendRequestsController < ApplicationController
  def create
    recipient = User.find(params[:id])
    return "Already friends" if current_user.friends.include?(recipient)
    return "Already sent" if current_user.request_recipients.include?(recipient.id)
    request = FriendRequest.new(sender: current_user, recipient: recipient)
    request.save!
  end

  def destroy
    request = FriendRequest.find(params[:id])
    request.destroy
  end

  def accept
    request = FriendRequest.find(params[:id])
    Friendship.create!(friend_a: request.sender, friend_b: request.recipient)
    request.destroy
  end
end
