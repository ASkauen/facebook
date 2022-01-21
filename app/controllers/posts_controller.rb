class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @posts = Post.all
    if current_user.posts.build(body: post_params[:body]).save
    end
  end

  def index
    @posts = Post.where(user_id: [*User.last.friends.pluck(:id), current_user.id]).order_desc
    @strangers = current_user.strangers.sample(5)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy!
  end

  private

  def post_params
    params.require(:post).permit([:body])
  end
end
