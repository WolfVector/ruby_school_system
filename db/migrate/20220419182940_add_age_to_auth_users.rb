class AddAgeToAuthUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :auth_users, :age, :integer
  end
end
