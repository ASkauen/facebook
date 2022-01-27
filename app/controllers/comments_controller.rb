class CommentsController < ApplicationController
  def create
    if comment_params[:post_id]
      comment = Post.find(comment_params[:post_id]).comments.build(body: comment_params[:body])
    elsif comment_params[:comment_id]
      comment = Comment.find(comment_params[:comment_id]).comments.build(body: comment_params[:body])
    end
    comment.author = current_user
    comment.save
  end

  def destroy
    Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit([:body, :post_id, :comment_id])
  end
end
