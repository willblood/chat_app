class CreateChat < ActiveRecord::Migration[7.1]
  def change
    create_table :chats, id: :uuid do |t|
      t.string :name, default: false
      t.timestamps
    end
  end
end
