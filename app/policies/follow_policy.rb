class FollowPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    user.present? && record.follower_id == user.id
  end
end
