class Post < ActiveRecord::Base
	resourcify
	
	belongs_to :user
	has_many :comments, dependent: :destroy

	mount_uploader :avatar, PictureUploader

	include PublicActivity::Model
	#tracked
	tracked owner: ->(controller, model) { controller && controller.current_user }
	
	acts_as_likeable

	default_scope -> { order('created_at DESC') }
end
