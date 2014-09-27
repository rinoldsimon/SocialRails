class Like < Socialization::ActiveRecordStores::Like
	include PublicActivity::Model
	#tracked
	tracked owner: ->(controller, model) { controller && controller.current_user }
end
