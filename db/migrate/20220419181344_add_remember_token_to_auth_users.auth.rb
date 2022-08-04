# This migration comes from auth (originally 20220418220043)
class AddRememberTokenToAuthUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :auth_users, :remember_token, :string, null: false
    add_index :auth_users, :remember_token, unique: true
  end
end
