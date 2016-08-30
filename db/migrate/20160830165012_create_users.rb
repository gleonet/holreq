class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :login, null: false
      t.string :password_digest
      t.string :email, null: false
      t.string :external_id
      t.references :site, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :enabled, default: true

      t.timestamps
    end
    add_index :users, :login, unique: true
    add_index :users, :email, unique: true
    add_index :users, :external_id, unique: true

    rename_column :users, :user_id, :manager_id
  end
end
