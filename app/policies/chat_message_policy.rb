class ChatMessagePolicy < ApplicationPolicy
  def create?
    user.present?
  end
end
