class CreateStaffs < ActiveRecord::Migration[7.0]
  def change
    create_table :staffs do |t|
      t.string :staff_name
      t.date :joining_date
      t.string :reporting_to
      t.string :email
      t.string :password_digest
      t.text :designation
      t.boolean :isStaff, default: true
      t.integer :admin_id, null: true, foreign_key: true
      t.integer :manager_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
