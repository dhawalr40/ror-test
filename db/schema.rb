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

ActiveRecord::Schema[8.0].define(version: 2026_07_02_064943) do
  create_table "brands", force: :cascade do |t|
    t.string "name", null: false
    t.string "country_of_origin", null: false
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "quantity", null: false
    t.integer "unit_price_cents", null: false
    t.integer "order_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.integer "total_cents", default: 0, null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "sku", null: false
    t.integer "price_cents", null: false
    t.decimal "alcohol_by_volume", precision: 5, scale: 2, default: "0.0"
    t.integer "stock_quantity", default: 0, null: false
    t.integer "brand_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["product_id"], name: "index_products_on_product_id"
    t.index ["sku"], name: "index_products_on_sku"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "full_name", null: false
    t.integer "role", default: 0, null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "products"
end
