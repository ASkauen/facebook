class LikesController < ApplicationController
  def create
    Post.find(params[:post]).likes.build(user: current_user).save!
  end

  def destroy
    Like.find_by(user: current_user, post: params[:post]).destroy
  end
end
