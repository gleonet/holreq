class AddRangeToLeaveRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :leave_requests, :range, :string
    add_column :leave_requests, :period, :string
  end
end
