class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.string :name

      t.timestamps
    end
    add_index :sites, :name, unique: true
  end
end
