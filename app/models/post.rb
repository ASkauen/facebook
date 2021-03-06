include ActionView::Helpers::DateHelper


class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: 'user_id'
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  scope :order_desc, ->{ all.order(created_at: :desc) }

  validates :body, presence: true, unless: ->{image.present?}
  validates :image, blob: { content_type: :image }

  after_create_commit {broadcast_prepend_to "posts", target: "posts"}
  after_destroy_commit {broadcast_remove_to "posts", target: self}

  def time_ago
    time_ago_in_words(created_at) + " ago"
  end
  
  def comments_and_replies
    out = []
    comments.each do |c|
      out << c
      c.all_replies.each {|r| out << r}
    end
    out.flatten
  end
end
