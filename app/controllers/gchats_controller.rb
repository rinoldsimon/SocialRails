class GchatsController < ApplicationController
	before_action :authenticate_user!

  def new
    @gchat = Gchat.new
    @gchats = Gchat.order('created_at DESC')
  end
 
  def create
  	respond_to do |format|
    if current_user
      @gchat = current_user.gchats.build(gchat_params)
      if @gchat.save
        flash.now[:success] = 'Your message was successfully posted!'
      else
        flash.now[:error] = 'Your message cannot be saved.'
      end
      format.html {redirect_to root_url}
      format.js
    else
      format.html {redirect_to root_url}
      format.js {render nothing: true}
    end
    end
  end

  private
 
  def gchat_params
    params.require(:gchat).permit(:body)
  end
end