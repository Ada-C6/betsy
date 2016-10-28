require 'csv'

users_list = []

CSV.read("seed_csvs/users.csv").each do |line|
  users_list.push(
  {
  # id: line[1],
  user_name: line[1],
  uid: line[2],
  provider: line[3],
  email: line[4]
})
end

users_list.each do |user_hash|
  User.create(user_hash)
end

products_list = []

CSV.read("seed_csvs/products.csv").each do |line|
  products_list.push(
  {
  # id: line[1],
  user_id: line[1],
  name: line[2],
  price: line[3],
  inventory: line[4],
  description: line[5],
  photo_url: line[6],
  retired: line[7]
})
end

products_list.each do |product_hash|
  Product.create(product_hash)
end


# ORDERS
orders_list = []

CSV.read("seed_csvs/orders.csv").each do |line|
  orders_list.push(
  {
  # id: line[1],
  billing_zip: line[1],
  cc_holder_name: line[2],
  cc_number: line[3],
  email: line[4],
  cvv: line[5],
  exp: line[6],
  mailing_address: line[7],
  mailing_city: line[8],
  mailing_state: line[9],
  mailing_zip: line[10],
  status: line[11],
  placed: line[12]
})
end

orders_list.each do |order_hash|
  Order.create(order_hash)
end

order_items_list = []

CSV.read("seed_csvs/orderItems.csv").each do |line|
  order_items_list.push(
  {
  # id: line[1],
  order_id: line[1],
  product_id: line[2],
  quantity: line[3]
})
end

order_items_list.each do |orderitem_hash|
  OrderItem.create(orderitem_hash)
end

reviews_list = []

CSV.read("seed_csvs/reviews.csv").each do |line|
  reviews_list.push(
  {
  # id: line[1],
  rating: line[1],
  review: line[2],
  product_id: line[3]
})
end

reviews_list.each do |review_hash|
  Review.create(review_hash)
end


categories_list = []
CSV.read("seed_csvs/categories.csv").each do |line|
  categories_list.push(

  # id: line[1], cannot be here
  line[1], #line starts at 0
  # product_id: line[2]
)
end

# categories_list.each do |category_hash|
#   Category.create(category_hash)
# end

final_product_list = Product.all
categories_list.length.times do |i|
  product_id = final_product_list[i].id
  category_hash = {
    name: categories_list.sample,
    product_ids: product_id
  }
  Category.create(category_hash)
end
