class CreateLeaveTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :leave_types do |t|
      t.string :leave_reason
      t.integer :days_allowed
      t.integer :staff_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
