# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

CSV.foreach('seed_csvs/products.csv', :headers => true ) do |prod_obj|
  Product.create(name: prod_obj["name"], unit_price: prod_obj["unit_price"], quantity: prod_obj["quantity"], description: prod_obj["description"], photo_url: prod_obj["photo_url"])
end
