class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :external_id

      t.timestamps
    end
    add_index :teams, :name, unique: true

    rename_column :teams, :user_id, :manager_id
  end
end
