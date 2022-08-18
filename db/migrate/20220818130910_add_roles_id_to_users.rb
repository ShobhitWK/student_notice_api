class AddRolesIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role_id, :integer
  end
end
