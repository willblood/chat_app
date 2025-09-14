class ChangeDefaultColumnToChat < ActiveRecord::Migration[7.1]
  def change
    change_column_null :chats, :name, false
    change_column_default :chats, :name, from: "f", to: nil    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
