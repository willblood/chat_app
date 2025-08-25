class CreateMessage < ActiveRecord::Migration[7.1]
  def change
    create_table :messages, id: :uuid do |t|
      t.references :chat, default: false
      t.references :user, default: false
      t.timestamps
    end
  end
end
