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

ActiveRecord::Schema[7.1].define(version: 2025_09_08_060743) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitor_products", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "name"
    t.string "platform"
    t.string "asin"
    t.decimal "latest_price"
    t.decimal "latest_rating"
    t.datetime "last_checked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_competitor_products_on_product_id"
  end

  create_table "competitor_snapshots", force: :cascade do |t|
    t.bigint "competitor_product_id", null: false
    t.decimal "price"
    t.decimal "rating"
    t.datetime "captured_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competitor_product_id"], name: "index_competitor_snapshots_on_competitor_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "merchant_id"
    t.string "title"
    t.decimal "price"
    t.string "currency"
    t.string "brand"
    t.string "gtin"
    t.string "mpn"
    t.string "link"
    t.string "image_link"
    t.text "icp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "competitor_products", "products"
  add_foreign_key "competitor_snapshots", "competitor_products"
end
