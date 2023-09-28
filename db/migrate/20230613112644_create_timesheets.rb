class CreateTimesheets < ActiveRecord::Migration[7.0]
  def change
    create_table :timesheets do |t|
      t.date :date
      t.time :start_time
      t.time :end_time
      t.string :task_detail
      t.string :task_stuffs
      t.string :addressed_issue
      t.string :issues_sorted
      t.string :sorted_by
      t.string :issues_discussed
      t.string :progress_details
      t.string :time_limit
      t.integer :task_id, null: true, foreign_key: true
      t.integer :staff_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
