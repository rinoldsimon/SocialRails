class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true, length: { maximum: 280 }

  scope :oldest, -> { order(created_at: :asc) }
end
