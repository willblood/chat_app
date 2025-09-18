class User < ApplicationRecord
  has_many :chat_users, dependent: :destroy
  has_many :chats, through: :chat_users, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_secure_password

  validates :name , :username, :password, presence: true
  validates :username, uniqueness: true
end