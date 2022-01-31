class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :user, uniqueness: {scope: :post, message: "user already liked"}

  after_create_commit do
    broadcast_update_to "likers",
                        partial: "posts/likers",
                        target: "likers#{post.id}",
                        locals: {post: post}
    broadcast_append_to "likers_full",
                        partial: "posts/liker",
                        target: "likers#{post.id}",
                        locals: {user: user}
  end

  after_destroy do
    if post
      broadcast_update_to "likers",
                          partial: "posts/likers",
                          target: "likers#{post.id}",
                          locals: {post: post}
      broadcast_remove_to "likers_full",
                          target: user
    end
  end
end
