class CreateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms do |t|
      t.string :your_name
      t.date :date_from
      t.date :date_to
      t.integer :days_applied
      t.string :leaving_type
      t.text :reason_for_leave
      t.string :status, default: 'pending'
      t.integer :staff_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
