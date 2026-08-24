class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(user: current_user))
    authorize @comment

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_back fallback_location: root_path }
      end
    else
      redirect_back fallback_location: root_path, alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @post = @comment.post
    @comment.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
