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

ActiveRecord::Schema.define(version: 20161028193634) do

  create_table "cart_products", force: :cascade do |t|
    t.integer  "product_quantity"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "product_id"
    t.integer  "cart_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_products", id: false, force: :cascade do |t|
    t.integer "product_id",  null: false
    t.integer "category_id", null: false
  end

  add_index "categories_products", ["category_id", "product_id"], name: "index_categories_products_on_category_id_and_product_id"
  add_index "categories_products", ["product_id", "category_id"], name: "index_categories_products_on_product_id_and_category_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.float    "unit_price"
    t.text     "description"
    t.string   "photo_url"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "product_id"
  end

  create_table "transaction_products", force: :cascade do |t|
    t.string   "product_name"
    t.integer  "product_unit_price"
    t.string   "product_description"
    t.integer  "product_quantity"
    t.integer  "product_total_price"
    t.string   "merchant_email"
    t.boolean  "mark_shipped"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "merchant_name"
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "merchant_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "status"
    t.integer  "total_price"
    t.string   "client_email"
    t.string   "client_address"
    t.string   "client_cc_num"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "client_name"
    t.string   "client_cc_exp"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.integer  "uid"
    t.string   "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.integer  "cart_id"
  end

end
