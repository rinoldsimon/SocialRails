class Comment < ActiveRecord::Base
	resourcify
	
	belongs_to :post
	belongs_to :user

	include PublicActivity::Model
	tracked owner: ->(controller, model) { controller && controller.current_user }
	 
	acts_as_likeable

	default_scope -> { order('created_at ASC') }
end
