class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :user, uniqueness: {scope: :post, message: "user already liked"}

  after_create_commit do
    broadcast_update_to "likers",
                        partial: "posts/likers",
                        target: "likers#{post.id}",
                        locals: {post: post}
  end

  after_destroy do
    if post
      broadcast_update_to "likers",
                          partial: "posts/likers",
                          target: "likers#{post.id}",
                          locals: {post: post}
    end
  end
end
