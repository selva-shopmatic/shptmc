class CreateMerchantSnapData < ActiveRecord::Migration[6.1]
  def change
    create_table :merchant_snap_data do |t|
      t.json :data
      t.integer :merchant_id
      t.timestamps
    end
  end
end
