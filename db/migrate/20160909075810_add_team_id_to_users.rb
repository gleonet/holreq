class AddTeamIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :team, index: true, foreign_key: true
    rename_column :users, :manager_id, :user_id
    remove_reference :users, :user, index: true, foreign_key: true
  end
end
