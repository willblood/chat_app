class MessagesController < ApplicationController
  before_action :user_logged_in?

  def create
    result = CreateMessage.execute(current_user: current_user, params: convert_key_to_sym(valid_params.to_h))
    if result.success?
      render json: result.message_data, status: :ok
    elsif result.message == "Chat does not exist"
      render json: {error: result.message}, status: :not_found
    else
      render json: {error: result.message}, status: :unprocessable_entity
    end
  end

  private
  def valid_params
    params.require(:message).permit(:chat_id, :content).merge(user_id: current_user.id)
  end
end