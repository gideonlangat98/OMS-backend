class CreateLeaveCalculations < ActiveRecord::Migration[7.0]
  def change
    create_table :leave_calculations do |t|
      t.string :staff_details
      t.string :type_of_leave
      t.integer :total_days
      t.integer :used_days
      t.integer :available_days
      t.integer :leave_type_id, null: true, foreign_key: true
      t.integer :staff_id, null: true, foreign_key: true
      t.timestamps
    end
  end
end
