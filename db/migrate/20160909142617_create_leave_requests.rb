class CreateLeaveRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_requests do |t|
      t.references :user, foreign_key: true
      t.references :leave, foreign_key: true
      t.references :leave_type, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.string :status
      t.integer :approved_by_id
      t.integer :nb_hours
      t.string :description

      t.timestamps
    end
    add_foreign_key :leave_requests, :users, column: :approved_by_id
    add_index :leave_requests, :approved_by_id
  end
end
