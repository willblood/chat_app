class ChatsController < ApplicationController
  before_action :authenticate_user

  def index
    chats = current_user.chats
    user_chats = []
    if chats.any?
      chats.each do |c|
        chat_user =  c.chat_users.where.not(user_id: current_user.id).first
        next unless chat_user
        last_message = c.messages.last
        user_chats << {chat_id: c.id, user_name: chat_user.user.name, user_id: chat_user.user_id, last_message: last_message&.content}
      end
    end
    p user_chats.inspect
    render json: user_chats, status: :ok
  end

  def show
    @chat = ChatRepository.find(params[:id])
    render json: chat, status: :ok
  end

  def create
    other_user = User.find_by(id: params[:user_id])
    return render json: { message: "Selected user doesn't exist" }, status: :not_found unless other_user

    result = CreateChat.execute(current_user: current_user, other_user: other_user)
    if result.success?
      render json: result.chat, status: :ok
    elsif result.message == "Chat already exists between the selected users."
      chat = find_chat(current_user, other_user)
      render json: {chat: chat, messages: chat.messages}, status: :ok
    else
      render json: { message: result.message }, status: :unprocessable_entity
    end
end

  private

  def find_chat(current_user, other_user)
    name =[current_user.id, other_user.id].sort.join("_")
    ChatRepository.find_by(name: name)
  end

end
