class ChatMessage < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: { maximum: 2000 }

  scope :newest, -> { order(created_at: :desc) }
  scope :oldest, -> { order(created_at: :asc) }

  after_create_commit -> {
    broadcast_append_to "yard", target: "yard-messages", partial: "chat_messages/chat_message", locals: { chat_message: self }
  }
end
