class CreateManagers < ActiveRecord::Migration[7.0]
  def change
    create_table :managers do |t|
      t.string :f_name
      t.string :l_name
      t.string :managers_title
      t.string :email
      t.string :password_digest
      t.boolean :isManager, default: true

      t.timestamps
    end
  end
end
