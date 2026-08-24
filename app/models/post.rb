class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true, length: { maximum: 500 }
  validates :link_url, format: { with: /\Ahttps?:\/\/.+/i, allow_blank: true, message: "must start with http:// or https://" }

  scope :newest, -> { order(created_at: :desc) }

  def self.feed_for(user, scope: :square)
    case scope.to_s
    when "following"
      ids = user.following_ids + [ user.id ]
      newest.where(user_id: ids)
    else
      newest
    end
  end

  def liked_by?(user)
    user && likes.exists?(user_id: user.id)
  end
end
