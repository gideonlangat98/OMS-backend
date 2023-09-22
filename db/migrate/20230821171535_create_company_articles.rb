class CreateCompanyArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :company_articles do |t|
      t.string :title
      t.date :date
      t.text :content
      t.integer :staff_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
