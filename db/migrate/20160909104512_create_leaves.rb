class CreateLeaves < ActiveRecord::Migration[5.0]
  def change
    create_table :leaves do |t|
      t.references :user, foreign_key: true
      t.integer :year
      t.references :leave_type, foreign_key: true
      t.integer :nb_hours

      t.timestamps
    end
  end
end
