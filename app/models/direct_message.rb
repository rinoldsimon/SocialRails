class DirectMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: true, length: { maximum: 2000 }

  after_create_commit -> {
    broadcast_append_to conversation, target: "direct-messages", partial: "direct_messages/direct_message", locals: { direct_message: self }
  }
end
