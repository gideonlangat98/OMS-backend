class CreateEndTimesheets < ActiveRecord::Migration[6.0]
  def change
    create_table :end_timesheets do |t|
      t.date :date
      t.time :end_time
      t.string :task_detail
      t.string :progress_details
      t.string :staff_id, null: false, foreign_key: true

      # Add any other specific attributes for EndTimesheet

      t.timestamps
    end
  end
end