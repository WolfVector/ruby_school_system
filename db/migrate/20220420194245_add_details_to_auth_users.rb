class AddDetailsToAuthUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :auth_users, :matricula, :string, null: false
    add_column :auth_users, :nombre, :string, null: false
    add_column :auth_users, :apaterno, :string, null: false
    add_column :auth_users, :amaterno, :string
    add_index :auth_users, :matricula, unique: true
  end
end
