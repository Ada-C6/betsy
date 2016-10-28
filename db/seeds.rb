# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'


CSV.read('seed_csvs/order.csv', :headers => true).map do |line|
  order_hash = {}
  order_hash[:id] = line[0]
  order_hash[:order_status] = line[1]
  Order.create(order_hash)
end

CSV.read('seed_csvs/product.csv', :headers => true).map do |line|
  product_hash = {}
  product_hash[:id] = line[0]
  product_hash[:name] = line[1]
  product_hash[:quantity] = line[2]
  product_hash[:price] = line[3]
  product_hash[:merchant_id] = line[4]
  Product.create(product_hash)
end

CSV.read('seed_csvs/merchant.csv', :headers => true).map do |line|
  merchant = {}
  merchant[:id] = line[0]
  merchant[:user_name] = line[1]
  merchant[:email] = line[2]
  merchant[:uid] = line[3]
  merchant[:provider] = line[4]
  Merchant.create(merchant)
end

CSV.read('seed_csvs/orderitem.csv', :headers => true).map do |line|
  orderitem_hash = {}
  orderitem_hash[:id] = line[0]
  orderitem_hash[:order_id] = line[1]
  orderitem_hash[:product_id] = line[2]
  orderitem_hash[:quantity] = line[3]
  OrderItem.create(orderitem_hash)
end

CSV.read('seed_csvs/review.csv', :headers => true).map do |line|
  review_hash = {}
  review_hash[:id] = line[0]
  review_hash[:product_id] = line[1]
  review_hash[:rating] = line[2]
  review_hash[:description] = line[3]
  Review.create(review_hash)
end

CSV.read('seed_csvs/category.csv', :headers => true).map do |line|
  category_hash = {}
  category_hash[:id] = line[0]
  category_hash[:name] = line[1]
  Category.create(category_hash)
end

CSV.read('seed_csvs/paymentinfo.csv', :headers => true).map do |line|
  order_hash = {}
  order_hash[:id] = line[0]
  order_hash[:order_id] = line[1]
  order_hash[:buyer_name] = line[2]
  order_hash[:email] = line[3]
  order_hash[:street] = line[4]
  order_hash[:city] = line[5]
  order_hash[:state] = line[6]
  order_hash[:zip] = line[7]
  order_hash[:cc_four_digits] = line[8]
  order_hash[:cc_expiration_date] = line[9]
  order_hash[:time_placed] = line[10]
  PaymentDetail.create(order_hash)
end

CSV.read('seed_csvs/category_product.csv', :headers => true).map do |line|
  category_product_hash = {}
  category_product_hash[:category_id] = line[0]
  category_product_hash[:product_id] = line[1]
  CategoriesProduct.create(category_product_hash)
end
