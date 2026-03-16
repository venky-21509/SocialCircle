class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  validates :follower_id, uniqueness: { scope: :followed_id }
  validates :status, inclusion: { in: %w[pending accepted rejected] }
  
  def accept!
    update!(status: 'accepted')
  end
  
  def reject!
    update!(status: 'rejected')
  end
  
  def accepted?
    status == 'accepted'
  end
  
  def pending?
    status == 'pending'
  end
end

