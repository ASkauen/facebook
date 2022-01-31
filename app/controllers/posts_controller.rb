class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @posts = Post.all
    if current_user.posts.build(body: post_params[:body], image: post_params[:image]).save
    end
  end

  def index
    @posts = Post.where(user_id: [*current_user.friends.pluck(:id), current_user.id]).order_desc
    @strangers = current_user.strangers.sample(5)
    post_likes = Post.joins(:likes).where("likes.created_at BETWEEN ? AND ?", 24.hours.ago, Time.now).group("likes.post_id").count
    @trending = post_likes.sort_by{|_k,v| v}.reverse.map(&:first).first(5).map {|id| Post.find(id)}

  end

  def destroy
    post = Post.find(params[:id])
    post.destroy!
    if request.referer[-6..-1] != ":3000/"
      redirect_to root_path
    end
  end

  def show
    @post = Post.find(params[:id])
    @likers = @post.likers
  end

  private

  def post_params
    params.require(:post).permit([:body, :image])
  end
end
