# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_18_042640) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "merchant_snap_data", force: :cascade do |t|
    t.json "data"
    t.integer "merchant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "page_views", force: :cascade do |t|
    t.json "data"
    t.integer "merchant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "canonical_name"
    t.string "sku"
    t.text "description"
    t.decimal "price"
    t.integer "status"
    t.integer "stock_sum", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "list_price"
    t.text "taxes_applicable", default: "--- {}\n"
    t.boolean "allow_oversell", default: true
    t.text "images", default: [], null: false, array: true
    t.string "slug"
    t.integer "site_id"
    t.string "upc_code"
    t.string "option_name"
    t.decimal "maximum_retail_price"
    t.text "shipping_details"
    t.integer "tenant_id", null: false
    t.integer "merchant_schema_id"
    t.integer "moderation_status", default: 2, null: false
    t.integer "sap_availability", default: 0
  end

end
