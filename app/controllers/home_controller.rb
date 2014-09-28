class HomeController < ApplicationController
	before_action :authenticate_user!
	
  def index
  	@post = Post.new
  	@posts = Post.order("id DESC").all

  	@users = User.all
  end
end
