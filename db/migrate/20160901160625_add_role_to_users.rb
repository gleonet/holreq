class AddRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :string, default: 'employee'
    add_index :users, :role
  end
end
