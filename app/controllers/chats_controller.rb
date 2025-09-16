class ChatsController < ApplicationController
  before_action :authenticate_user

  def index
    chats = current_user.chats
    render json: chats, status: :ok
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
      render json: chat, status: :ok
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
