class GchatsController < ApplicationController
	before_action :authenticate_user!
	
  def new
    @gchat = Gchat.new
  end
 
  def create
  end
end