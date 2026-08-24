class PostsController < ApplicationController
  def create
    @post = current_user.posts.build(post_params)
    authorize @post

    if @post.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path, notice: "Posted to the square." }
      end
    else
      @scope = :square
      @posts = Post.feed_for(current_user, scope: @scope).includes(:user, :likes, comments: :user)
      @suggested = User.where.not(id: current_user.id).limit(5)
      render "home/index", status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post
    @post.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path, notice: "Post removed." }
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :link_url)
  end
end
