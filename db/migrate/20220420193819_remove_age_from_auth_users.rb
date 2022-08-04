class RemoveAgeFromAuthUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :auth_users, :age, :integer
  end
end
