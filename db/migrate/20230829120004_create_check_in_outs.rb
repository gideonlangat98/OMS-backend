class CreateCheckInOuts < ActiveRecord::Migration[7.0]
  def change
    create_table :check_in_outs do |t|
      t.string :name
      t.string :duration
      t.integer :staff_id, null: true, foreign_key: true
      t.datetime :check_in
      t.datetime :check_out
      t.string :online_state, default: 'offline'
      t.string :last_logged
      t.timestamps
    end
  end
end
