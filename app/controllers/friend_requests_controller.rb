class FriendRequestsController < ApplicationController
  def create
    recipient = User.find(params[:id])
    return "Already friends" if current_user.friends.include?(recipient)
    return "Already sent" if current_user.request_recipients.include?(recipient.id)
    request = FriendRequest.new(sender: current_user, recipient: recipient)
    if request.save
      update_button(request, recipient)
    end
  end

  def destroy
    recipient = User.find(params[:id])
    request = FriendRequest.find_by(sender_id: current_user, recipient_id: recipient.id)
    request.destroy
    update_button(request, recipient)
  end

  def accept
    request = FriendRequest.find(params[:id])
    Friendship.create!(user: request.sender, friend: request.recipient)
    request.destroy
  end

  private

  def update_button(request, recipient)
    friend_requests = current_user.sent_friend_requests.pluck(:recipient_id)
    request.broadcast_update_to "friend_requests",
                        partial: "users/buttons/add_friend",
                        target: "friend-button",
                        locals: {friend_requests: friend_requests, user: recipient, sender: current_user}
  end
end
