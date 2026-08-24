class LikesController < ApplicationController
  def create
    @likeable = find_likeable
    @like = @likeable.likes.find_or_initialize_by(user: current_user)
    authorize @like
    @like.save!
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path }
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    authorize @like
    @likeable = @like.likeable
    @like.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path }
    end
  end

  private

  def find_likeable
    type = params[:likeable_type]
    raise ActiveRecord::RecordNotFound unless %w[Post Comment].include?(type)

    type.constantize.find(params[:likeable_id])
  end
end
