class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.date :date
      t.time :time
      t.string :agenda
      t.string :host
      t.string :trainer
      t.string :documents
      t.string :email
      t.string :meeting_link
      t.integer :staff_id, null: true, foreign_key: true
      t.integer :client_id, null: true, foreign_key: true
      t.integer :manager_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end