class CreateLeaveTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_types do |t|
      t.string :name
      t.string :description, null: false

      t.timestamps
    end
    add_index :leave_types, :name, unique: true
  end
end
