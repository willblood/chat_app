class RebuildMessageTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :messages
    create_table :messages, id: :uuid do |t|
      t.references :chat, null: false, type: :uuid, foreign_key: true
      t.references :user, null: false, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
