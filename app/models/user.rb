class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :google_oauth2, :github ]

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :chat_messages, dependent: :destroy
  has_many :direct_messages, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :conversations, through: :memberships

  has_many :active_follows, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy, inverse_of: :follower
  has_many :passive_follows, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy, inverse_of: :followed
  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower

  validates :name, presence: true, length: { maximum: 80 }
  validates :username, presence: true, uniqueness: { case_sensitive: false },
            format: { with: /\A[a-z0-9_]+\z/, message: "use lowercase letters, numbers, and underscores" },
            length: { in: 3..24 }
  validates :bio, length: { maximum: 280 }, allow_blank: true
  validates :github_username, length: { maximum: 39 }, allow_blank: true

  before_validation :normalize_username

  def to_param
    username
  end

  def following?(other)
    following.include?(other)
  end

  def follow(other)
    following << other unless other == self || following?(other)
  end

  def unfollow(other)
    following.delete(other)
  end

  def initials
    name.to_s.split.map { |p| p[0] }.first(2).join.upcase.presence || "?"
  end

  def self.from_omniauth(auth)
    user = find_by(provider: auth.provider, uid: auth.uid)
    return user if user

    email = auth.info.email.presence || "#{auth.provider}-#{auth.uid}@users.socialrails.local"
    user = find_by(email: email)
    if user
      user.update!(provider: auth.provider, uid: auth.uid)
      return user
    end

    create!(
      email: email,
      password: Devise.friendly_token[0, 20],
      name: auth.info.name.presence || auth.info.nickname.presence || "Builder",
      username: unique_username_from(auth),
      github_username: (auth.info.nickname if auth.provider.to_s == "github"),
      provider: auth.provider,
      uid: auth.uid
    )
  end

  def self.unique_username_from(auth)
    base = (auth.info.nickname.presence || auth.info.email.to_s.split("@").first || "builder")
             .parameterize(separator: "_")
             .gsub(/[^a-z0-9_]/, "")
             .first(18)
    base = "builder" if base.blank? || base.length < 3
    candidate = base
    n = 1
    while exists?(username: candidate)
      n += 1
      candidate = "#{base.first(16)}_#{n}"
    end
    candidate
  end

  private

  def normalize_username
    self.username = username.to_s.downcase.strip
  end
end
