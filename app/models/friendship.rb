class Friendship < ApplicationRecord
  belongs_to :friend_a, class_name: 'User', foreign_key: :user_a_id
  belongs_to :friend_b, class_name: 'User', foreign_key: :user_b_id
  scope :between, ->(user_a, user_b){find_by(friend_a: user_a, friend_b: user_b) || find_by(friend_a: user_b, friend_b: user_a)}

  validates :friend_a, uniqueness: {scope: :friend_b, message: "users are already friends"}
  validates :friend_b, uniqueness: {scope: :friend_a, message: "users are already friends"}

  after_create_commit do
    broadcast_prepend_to "friends", partial: "users/user", target: "friends#{friend_a.id}", locals: {user: friend_b}
    broadcast_prepend_to "friends", partial: "users/user", target: "friends#{friend_b.id}", locals: {user: friend_a}
  end

  after_destroy_commit do
    broadcast_remove_to "friends", target: friend_a
    broadcast_remove_to "friends", target: friend_b
  end
end
