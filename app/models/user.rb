require 'down'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]
  has_many :posts, inverse_of: 'author', dependent: :destroy
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  has_many :friend_requests
  has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: :recipient_id, dependent: :destroy
  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: :sender_id, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friendships_as_user_a, class_name: 'Friendship', foreign_key: :user_a_id
  has_many :friends_from_a, through: :friendships_as_user_a, class_name: 'User', source: :friend_b
  has_many :friendships_as_user_b, class_name: 'Friendship', foreign_key: :user_b_id
  has_many :friends_from_b, through: :friendships_as_user_b, class_name: 'User', source: :friend_a

  has_one_attached :avatar, dependent: :destroy

  validates :avatar, blob: { content_type: :image }
  validates :email, uniqueness: true, presence: true

  before_create do
    set_avatar
  end

  after_update {broadcast_update_to "user_bio", partial: "users/bio", target: "bio#{id}", locals: {user: self}}

  def friends_with?(user)
    friends.include?(user)
  end

  def friendships
    friendships_as_user_a + friendships_as_user_b
  end

  def friends
    friends_from_a + friends_from_b
  end

  def has_liked?(post)
    liked_posts.include?(post)
  end

  def friendship_with(user)
    Friendship.find_by("user_a_id = ? OR user_b_id = ?", user.id, user.id)
  end

  def strangers
    (User.all - friends - [self])
  end

  def notifications
    received_friend_requests
  end
  
  def request_to(user)
    sent_friend_requests.find_by(recipient: user)
  end
  
  def request_from(user)
    received_friend_requests.find_by(sender: user)
  end

  def request_with(user)
    FriendRequest.find_by(recipient: self, sender: user) || FriendRequest.find_by(recipient: user, sender: self)
  end

  def request_recipients
    sent_friend_requests.pluck(:recipient_id)
    end

  def request_senders
    received_friend_requests.pluck(:sender_id)
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
