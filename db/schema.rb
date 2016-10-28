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

ActiveRecord::Schema.define(version: 20161028174827) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_products", id: false, force: :cascade do |t|
    t.integer "product_id",  null: false
    t.integer "category_id", null: false
  end

  add_index "categories_products", ["category_id"], name: "index_categories_products_on_category_id"
  add_index "categories_products", ["product_id"], name: "index_categories_products_on_product_id"

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity",   default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "shipped",    default: false
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id"
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id"

  create_table "orders", force: :cascade do |t|
    t.datetime "placed"
    t.string   "email"
    t.string   "mailing_address"
    t.string   "mailing_city"
    t.string   "mailing_state"
    t.string   "mailing_zip"
    t.string   "cc_holder_name"
    t.integer  "cc_number",       limit: 6
    t.date     "exp"
    t.integer  "cvv"
    t.string   "billing_zip"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "status"
  end

  create_table "products", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "price",       default: 0
    t.integer  "inventory",   default: 0
    t.string   "description"
    t.string   "photo_url"
    t.boolean  "retired"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id"

  create_table "reviews", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "review"
    t.integer  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reviews", ["product_id"], name: "index_reviews_on_product_id"

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "uid"
    t.string   "provider"
  end

end
