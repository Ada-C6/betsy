# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161028175307) do

  create_table "order_items", force: :cascade do |t|
    t.decimal  "unit_price"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order_id"
    t.integer  "product_id"
    t.string   "status"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id"
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id"

  create_table "orders", force: :cascade do |t|
    t.string   "status",         limit: 80
    t.string   "name"
    t.string   "email"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "phone"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "cc_number"
    t.integer  "exp_month"
    t.integer  "exp_year"
    t.integer  "cvc"
  end

  add_index "orders", ["product_id"], name: "index_orders_on_product_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price"
    t.string   "photo_url"
    t.integer  "inventory"
    t.string   "category"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.string   "alt_id"
    t.string   "alt_text"
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id"

  create_table "reviews", force: :cascade do |t|
    t.text     "description"
    t.integer  "rank"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "product_id"
    t.integer  "user_id"
    t.string   "title"
  end

  add_index "reviews", ["product_id"], name: "index_reviews_on_product_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "phone"
    t.boolean  "merchant"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "provider",              default: "false"
    t.boolean  "status"
    t.string   "password_digest"
    t.string   "password_confirmation"
    t.integer  "uid",                   default: 0
  end

end
