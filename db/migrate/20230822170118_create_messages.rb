class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.string :channel
      t.integer :admin_id, null: true, foreign_key: true
      t.integer :staff_id, null: true, foreign_key: true
      t.boolean :read, default: false
      t.string :sender_type

      t.timestamps
    end
  end
end
