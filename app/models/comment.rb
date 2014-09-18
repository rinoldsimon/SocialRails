class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user
	include PublicActivity::Common
	# tracked except: :update, owner: ->(controller, model) { controller && controller.current_user }
end
