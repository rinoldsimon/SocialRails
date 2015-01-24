class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

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

  has_many :messages

  after_create :send_signup_email 

  private

    def send_signup_email
      UserNotifier.send_signup_email(self).deliver
    end
end
