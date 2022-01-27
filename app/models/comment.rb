class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :user_id
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, presence: true

  after_create_commit { broadcast_update_to "comments", partial: "comments/for_commentable", target: "comments#{post.id}", locals: {commentable: post}}
  after_destroy_commit { broadcast_update_to "comments", partial: "comments/for_commentable", target: "comments#{post.id}", locals: {commentable: post}}

  def post(comment = self)
    commentable = comment.commentable
    return commentable if commentable.is_a?(Post)
    post(commentable)
  end

  def all_replies(all = [])
    return all unless comments.any?

    all << comments
    comments.each do |c|
      return c.all_replies(all)
    end
  end
end
