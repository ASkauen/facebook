class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: 'user_id'
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  scope :order_desc, ->{ all.order(created_at: :desc) }

  validates :body, presence: true

  after_create_commit {broadcast_prepend_to "posts", target: "posts"}
  after_destroy_commit {broadcast_remove_to "posts", target: self}
end
