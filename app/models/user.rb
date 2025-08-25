class User < ApplicationRecord
  has_many :chat_users
  has_many :chats, through: :chat_users
  has_many :messages, dependent: :destroy

  validates :name , :username, :password, presence: true
  validates :username, uniqueness: true
end