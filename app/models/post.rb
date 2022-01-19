class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: 'user_id'

  scope :order_desc, ->{ all.order(created_at: :desc) }

  validates :body, presence: true
end
