class ChatsController < ApplicationController
  before_action :user_logged_in?
  def index
    @chats = current_user.chats
  end

  def show
    @chat = ChatRepository.find(params[:id])
  end

  def create
    other_user = UserRepository.find(params[:user_id])
    if other_user
      result = CreateChat.execute(current_user: current_user, other_user: other_user)
      if result.success?
        flash[:success] = "New chat created !"
      elsif result.message == "Chat already exists between the selected users."
        chat = find_chat(current_user, other_user)
        redirect_to chat_path(chat.id)
      else
        flash[:errors] = "Failed to create User"
      end
    end
    flash[:errors] = "Selected user doesn't exist"
  end

  private

  def find_chat(current_user, other_user)
    name =[current_user.id, other_user.id].sort.join("_")
    ChatRepository.find_by(name: name)
  end

end
