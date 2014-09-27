class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user

	include PublicActivity::Model
	tracked owner: ->(controller, model) { controller && controller.current_user }
	 
	acts_as_likeable
end
