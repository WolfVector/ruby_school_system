class AddRolToAuthUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :auth_users, :rol, :integer
  end
end
