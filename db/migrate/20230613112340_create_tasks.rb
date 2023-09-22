class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.date :assignment_date
      t.string :task_name
      t.string :assigned_to
      t.string :task_manager
      t.string :project_manager
      t.string :project_name
      t.string :task_deadline
      t.string :avatar_image
      t.string :completed_files
      t.string :send_type
      t.boolean :isSeen, default: false
      t.integer :project_id, null: true, foreign_key: true
      t.integer :staff_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
