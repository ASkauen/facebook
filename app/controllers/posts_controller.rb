class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @posts = Post.all
    if current_user.posts.build(body: post_params[:body]).save
      update_feed
    end
  end

  def index
    @posts = Post.all
    @strangers = current_user.strangers.sample(5)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy!
    update_feed
  end

  private

  def update_feed
    Turbo::StreamsChannel.broadcast_update_to 'posts', partial: "posts/posts", target: "posts", locals: {posts: Post.order_desc, user: current_user}
  end

  def post_params
    params.require(:post).permit([:body])
  end
end
