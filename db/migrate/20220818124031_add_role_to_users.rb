class AddRoleToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :current_role, :string
  end
end
