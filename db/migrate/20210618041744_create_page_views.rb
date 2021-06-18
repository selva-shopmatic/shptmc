class CreatePageViews < ActiveRecord::Migration[6.1]
  def change
    create_table :page_views do |t|
      t.json :data
      t.integer :merchant_id
      t.timestamps
    end
  end
end
