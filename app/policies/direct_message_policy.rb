class DirectMessagePolicy < ApplicationPolicy
  def create?
    user.present? && record.conversation.users.exists?(id: user.id)
  end
end
