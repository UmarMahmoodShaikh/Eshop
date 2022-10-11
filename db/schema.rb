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

ActiveRecord::Schema[7.0].define(version: 2022_09_13_073323) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "name"
    t.text "detail"
    t.bigint "shopper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shopper_id"], name: "index_addresses_on_shopper_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.text "slogan"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_brands_on_company_id"
  end

  create_table "carts", force: :cascade do |t|
    t.decimal "total"
    t.bigint "shopper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "qty", default: 0, null: false
    t.jsonb "products"
    t.index ["shopper_id"], name: "index_carts_on_shopper_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats", force: :cascade do |t|
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.text "about"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.bigint "shopper_id"
    t.integer "retailer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "shopper_address"
    t.jsonb "products"
    t.integer "grand_total"
    t.index ["shopper_id"], name: "index_orders_on_shopper_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.text "description"
    t.bigint "brand_id"
    t.integer "quantity"
    t.boolean "availability"
    t.bigint "subcategory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "DETAILS", limit: 200
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["subcategory_id"], name: "index_products_on_subcategory_id"
  end

  create_table "retailers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "pass"
    t.text "phone"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shoppers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "pass"
    t.text "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
