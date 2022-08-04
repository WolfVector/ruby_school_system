class AddTokenToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :remember_token, :string, null: false
    add_index :admins, :remember_token, unique: true
  end
end
