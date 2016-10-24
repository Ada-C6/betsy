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

ActiveRecord::Schema.define(version: 20161024184627) do

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

  create_table "merchants", force: :cascade do |t|
    t.string   "user_name"
    t.string   "email"
    t.integer  "uid",        null: false
    t.string   "provider",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "quantity",   default: 1
    t.integer  "product_id"
    t.integer  "order_id"
    t.boolean  "shipped?",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "status",         default: "PENDING"
    t.datetime "date_purchased"
    t.string   "email"
    t.string   "address"
    t.string   "cc_name"
    t.integer  "cc_number"
    t.integer  "cc_exp_year"
    t.integer  "cc_exp_month"
    t.integer  "billing_zip"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "total",          default: 0
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "stock"
    t.integer  "price"
    t.string   "photo_url"
    t.integer  "merchant_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "active?",     default: true
  end

  add_index "products", ["merchant_id"], name: "index_products_on_merchant_id"

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.string   "description"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
