class FriendRequestsController < ApplicationController
  def create
    recipient = User.find(params[:id])
    return "Already friends" if current_user.friends.include?(recipient)
    return "Already sent" if current_user.request_recipients.include?(recipient.id)
    request = FriendRequest.new(sender: current_user, recipient: recipient)
    request.save!
  end

  def destroy
    request = FriendRequest.find(params[:id]) rescue nil
    if request
      request.destroy
    else
      flash[:alert] = "Request does not exist"
      redirect_to root_path
    end
  end

  def accept
    request = FriendRequest.find(params[:id]) rescue nil
    if request
      Friendship.create!(friend_a: request.sender, friend_b: request.recipient)
      request.destroy
    else
      flash[:alert] = "Could not accept request"
      redirect_to root_path
    end
  end

  def generate
    current_user.generate_friend_request
  end
end
