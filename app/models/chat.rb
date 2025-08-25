class Chat <ApplicationRecord
  has_many :messages
  has_many :chat_users
  validates :name, presence: true
end