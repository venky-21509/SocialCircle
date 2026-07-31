class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  # Follow relationships
  has_many :followed_relationships, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
  has_many :followed_users, through: :followed_relationships, source: :followed
  
  has_many :follower_relationships, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower
  
  # Only count accepted follows
  has_many :accepted_followed_relationships, -> { where(status: 'accepted') }, class_name: "Follow", foreign_key: :follower_id
  has_many :accepted_followed_users, through: :accepted_followed_relationships, source: :followed
  
  has_many :accepted_follower_relationships, -> { where(status: 'accepted') }, class_name: "Follow", foreign_key: :followed_id
  has_many :accepted_followers, through: :accepted_follower_relationships, source: :follower

  validates :username, presence: true, uniqueness: { case_sensitive: false }, 
            length: { minimum: 3, maximum: 20 },
            format: { with: /\A[a-zA-Z0-9_]+\z/, message: "can only contain letters, numbers, and underscores" }
  validates :name, presence: true, length: { maximum: 50 }

  def follow(user)
    followed_relationships.create(followed: user, status: 'pending') unless following?(user)
  end

  def unfollow(user)
    followed_relationships.where(followed: user).destroy_all
  end

  def following?(user)
    accepted_followed_relationships.exists?(followed_id: user.id)
  end

  def followers_count
    accepted_followers.count
  end

  def following_count
    accepted_followed_users.count
  end
  
  def feed_posts
    Post.where(user_id: accepted_followed_user_ids).or(Post.where(user_id: id))
         .includes(:user, :likes, :comments)
         .order(created_at: :desc)
  end
end
