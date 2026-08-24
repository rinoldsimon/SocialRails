class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :followed_id, uniqueness: { scope: :follower_id }
  validate :not_self

  private

  def not_self
    errors.add(:followed_id, "can't follow yourself") if follower_id == followed_id
  end
end
