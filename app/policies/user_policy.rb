class UserPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    true
  end
end
