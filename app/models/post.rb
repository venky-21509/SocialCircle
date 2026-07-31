class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  validates :content, presence: true, length: { maximum: 1000 }
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
  
  def likes_count
    likes.count
  end
  
  def comments_count
    comments.count
  end
end
