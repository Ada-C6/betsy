# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

CSV.foreach('seed_csvs/products.csv', :headers => true ) do |prod_obj|
  Product.create(id: prod_obj["product_id"], name: prod_obj["name"], unit_price: prod_obj["unit_price"], quantity: prod_obj["quantity"], description: prod_obj["description"], photo_url: prod_obj["photo_url"], user_id: prod_obj["user_id"])
end


CSV.foreach('seed_csvs/users.csv', :headers => true ) do |user_obj|
  User.create(id: user_obj["user_id"], name: user_obj["name"], email: user_obj["email"], provider: user_obj["provider"], uid: user_obj["uid"])
end

CSV.foreach('seed_csvs/categories.csv', :headers => true ) do |cat_obj|
  Category.create(id: cat_obj["category_id"], name: cat_obj["name"])
end

CSV.foreach('seed_csvs/categories_products.csv', :headers => true ) do |cat_prod|
  Product.find(cat_prod["product_id"]).categories << Category.find(cat_prod["category_id"])
end
