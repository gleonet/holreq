class CreateLegalDays < ActiveRecord::Migration[5.0]
  def change
    create_table :legal_days do |t|
      t.integer :year
      t.datetime :start_date
      t.string :name
      t.references :site, foreign_key: true

      t.timestamps
    end
    add_index :legal_days, :year
  end
end
