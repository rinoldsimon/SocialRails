class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :contacts

  include Gravtastic
  gravtastic

  mount_uploader :avatar, PictureUploader

  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships, dependent: :destroy
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", dependent: :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user, dependent: :destroy

  acts_as_liker

  def self.search(query)
    where("name like ?", "%#{query}%") 
  end

  has_many :messages, dependent: :destroy

  after_create :send_signup_email 

  private

    def send_signup_email
      UserNotifier.send_signup_email(self).deliver
    end

  has_many :gchats, dependent: :delete_all

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name # assuming the user model has a name
      user.remote_avatar_url = auth.info.image.gsub('http://','https://') # assuming the user model has an image 
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.name = data["name"] if user.name.blank?

      elsif data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.name = data["name"] if user.name.blank?
      end
    end
  end

end
