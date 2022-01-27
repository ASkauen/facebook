class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.where.not(id: current_user.id).order(:first_name)
  end

  def update_avatar
    user = User.find(params[:id])
    user.update(avatar: params[:avatar])
  end

  def update
    User.find(params[:id]).update!(bio: params[:user][:bio])
  end
end
