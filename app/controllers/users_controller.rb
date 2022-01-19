class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
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
