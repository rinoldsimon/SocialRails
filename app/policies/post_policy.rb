class PostPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    owner?
  end

  private

  def owner?
    user.present? && record.user_id == user.id
  end
end
