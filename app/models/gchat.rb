class Gchat < ActiveRecord::Base
  belongs_to :user
  validates :body, presence: true, length: {maximum: 2000}
end
