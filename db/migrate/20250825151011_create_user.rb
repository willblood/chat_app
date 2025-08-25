class CreateUser < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name, default: false
      t.string :username
      t.string :password_digest

      t.timestamps
    end
  end
end
