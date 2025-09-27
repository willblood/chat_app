class AddContentColumnToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :content, :text, null: false
  end
end
