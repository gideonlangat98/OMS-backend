class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :request_by
      t.string :request_detail
      t.date :request_date
      t.string :request_to
      t.integer :staff_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
