class DirectMessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @direct_message = @conversation.direct_messages.build(direct_message_params.merge(user: current_user))
    authorize @direct_message

    if @direct_message.save
      @conversation.touch
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("dm-form", partial: "direct_messages/form", locals: { conversation: @conversation, direct_message: DirectMessage.new }) }
        format.html { redirect_to @conversation }
      end
    else
      redirect_to @conversation, alert: @direct_message.errors.full_messages.to_sentence
    end
  end

  private

  def direct_message_params
    params.require(:direct_message).permit(:body)
  end
end
