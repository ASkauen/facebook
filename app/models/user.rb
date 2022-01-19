require 'down'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]
  has_many :posts, inverse_of: 'author', dependent: :destroy
  has_many :friend_requests
  has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: :recipient_id, dependent: :destroy
  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: :sender_id, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, ->(user){ joins(:friendships).where("friendships.user_id = ? OR friendships.friend_id = ?", user.id, user.id) }, class_name: "User"
  has_one_attached :avatar, dependent: :destroy

  validates :avatar, blob: { content_type: :image }
  validates :email, uniqueness: true, presence: true

  before_create do
    set_avatar
  end

  def strangers
    (User.all - friends - [self])
  end

  def notifications
    received_friend_requests
  end

  def request_recipients
    sent_friend_requests.pluck(:recipient_id)
  end

  def avatar_thumbnail(size = "32")
    avatar.variant(:gravity=>"Center", resize: "#{size}x#{size}^", crop: "#{size}x#{size}+0+0").processed
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def set_avatar(url = "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y")
    image = Down.download(url)
    avatar.attach(io: image, filename: "avatar.jpg")
  end
end
