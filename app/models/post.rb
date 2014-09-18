class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments

	mount_uploader :avatar, PictureUploader

	include PublicActivity::Model
	#tracked
	tracked owner: ->(controller, model) { controller && controller.current_user }
	
	acts_as_likeable
end
