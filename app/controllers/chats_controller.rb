class ChatsController < ApplicationController
  before_action :user_logged_in?
  def index
    chats = current_user.chats
    render json: chats, status: :ok
  end

  def show
    @chat = ChatRepository.find(params[:id])
    render json: chat, status: :ok
  end

  def create
    other_user = UserRepository.find(params[:user_id])
    if other_user
      result = CreateChat.execute(current_user: current_user, other_user: other_user)
      if result.success?
        render json: result.chat, status: :ok
      elsif result.message == "Chat already exists between the selected users."
        chat = find_chat(current_user, other_user)
        render json: chat, status: :ok
      else
        render json: {message: result.message}, status: :unprocessable_entity
      end
    end
    render json: {message: "Selected user doesn't exist"}, status: :not_found
  end

  private

  def find_chat(current_user, other_user)
    name =[current_user.id, other_user.id].sort.join("_")
    ChatRepository.find_by(name: name)
  end

end
