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

ActiveRecord::Schema.define(version: 20161025212925) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_tables", force: :cascade do |t|
  end

  create_table "category_products", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "product_id",  null: false
  end

  add_index "category_products", ["category_id"], name: "index_category_products_on_category_id"
  add_index "category_products", ["product_id"], name: "index_category_products_on_product_id"

  create_table "merchants", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "uid"
    t.string   "provider"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "product_id"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id"
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id"

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "name"
    t.string   "email"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "mailing_zip"
    t.string   "cc_number"
    t.integer  "cc_exp_month"
    t.integer  "cc_exp_year"
    t.integer  "cc_sec_code"
    t.string   "billing_zip"
    t.string   "order_status"
    t.datetime "time_placed"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "merchant_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "inventory"
    t.string   "description"
    t.integer  "category_id"
    t.string   "photo_url"
    t.boolean  "active"
  end

  add_index "products", ["merchant_id"], name: "index_products_on_merchant_id"

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
  end

  add_index "reviews", ["product_id"], name: "index_reviews_on_product_id"

end
