class Conversation < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :direct_messages, dependent: :destroy

  def self.between(user_a, user_b)
    joins(:memberships)
      .where(memberships: { user_id: [ user_a.id, user_b.id ] })
      .group("conversations.id")
      .having("COUNT(DISTINCT memberships.user_id) = 2")
      .detect { |c| c.user_ids.sort == [ user_a.id, user_b.id ].sort }
  end

  def self.find_or_create_between(user_a, user_b)
    existing = between(user_a, user_b)
    return existing if existing

    create!.tap do |conversation|
      conversation.memberships.create!(user: user_a)
      conversation.memberships.create!(user: user_b)
    end
  end

  def other_than(user)
    users.where.not(id: user.id).first
  end
end
