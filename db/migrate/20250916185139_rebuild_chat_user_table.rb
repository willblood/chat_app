class RebuildChatUserTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :chat_users
    create_table :chat_users, id: :uuid do |t|
      t.references :chat, null: false, type: :uuid, foreign_key: true
      t.references :user, null: false, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
