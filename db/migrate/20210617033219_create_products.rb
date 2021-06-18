class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string   "name"
      t.string   "canonical_name"
      t.string   "sku"
      t.text     "description"
      t.decimal  "price"
      t.integer  "status"
      t.integer  "stock_sum",            default: 0
      t.datetime "created_at",                                null: false
      t.datetime "updated_at",                                null: false
      t.decimal  "list_price"
      t.text     "taxes_applicable",     default: "--- {}\n"
      t.boolean  "allow_oversell",       default: true
      t.text     "images",               default: [],         null: false, array: true
      t.string   "slug"
      t.integer  "site_id"
      t.string   "upc_code"
      t.string   "option_name"
      t.decimal  "maximum_retail_price"
      t.text     "shipping_details"
      t.integer  "tenant_id",                                 null: false
      t.integer  "merchant_schema_id"
      t.integer  "moderation_status",    default: 2,          null: false
      t.integer  "sap_availability",     default: 0
    end
  end
end
