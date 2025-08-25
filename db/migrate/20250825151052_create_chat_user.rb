class CreateChatUser < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_users, id: :uuid do |t|
      t.references :user, default: false
      t.references :chat, default: false
      t.timestamps
    end
  end
end
