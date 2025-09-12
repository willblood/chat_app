class ChatsController < ApplicationController
  before_action :user_logged_in?
  def index
    @chats = current_user.chats
  end

  def show
    @chat = ChatRepository.find(params[:id])
  end
end
