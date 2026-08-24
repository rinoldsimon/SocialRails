class ConversationPolicy < ApplicationPolicy
  def show?
    member?
  end

  def create?
    user.present?
  end

  private

  def member?
    user.present? && record.users.exists?(id: user.id)
  end
end
