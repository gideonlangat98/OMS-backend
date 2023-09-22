class CreateProgresses < ActiveRecord::Migration[7.0]
  def change
    create_table :progresses do |t|
      t.string :progress_by
      t.string :task_managed
      t.string :project_managed
      t.date :assigned_date
      t.date :start_date
      t.string :exceeded_by
      t.date :delivery_time
      t.integer :staff_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
