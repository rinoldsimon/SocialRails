class Contact < ActiveRecord::Base
	validates :email, :email => true
	belongs_to :user
end
