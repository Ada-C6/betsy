# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'csv'

def to_bool(string)
  if string.downcase == "true"
    return true
  else
    return false
  end
end

puts "In DB Seedfile"

# seed Users
CSV.foreach('seed_csvs/users.csv') do |line|
  user = User.create(first_name: line[0], last_name: line[1], email: line[2], birthdate: line[3], phone: line[4], admin: to_bool(line[5]), active: to_bool(line[6]), uid: line[7].to_i, provider: line[8])
  if user.valid?
    puts "User #{user.first_name} created sucessfully."
  else
    puts "User #{user.first_name} failed. Errors: #{user.errors}"
  end
end

puts "In Read in Users"
# seed Addresses
CSV.foreach('seed_csvs/addresses.csv') do |line|
  address = Address.create(kind: line[0], first_name: line[1], last_name: line[2], street1: line[3], street2: line[4], city: line[5], state: line[6], zip: line[7], country: line[8], phone: line[9], user_id: line[10].to_i)
  if address.valid?
    puts "Address #{address.first_name} created sucessfully."
  else
    puts "Address #{address.first_name} failed. Errors: #{address.errors}"
  end
end

puts "In Read in Addresses"

# seed Categories
CSV.foreach('seed_csvs/categories.csv') do |line|
  category = Category.create(name: line[0], picture: line[1])
  if category.valid?
    puts "Category #{category.name} created sucessfully."
  else
    puts "Category #{category.name} failed. Errors: #{category.errors}"
  end
end

puts "In Read in categories"
# seed Products
CSV.foreach('seed_csvs/products.csv') do |line|
  product = Product.create(name: line[0], description: line[1], price: line[2].to_i, inventory_qty: line[3].to_i, active: to_bool(line[4]), category_id: line[5].to_i, picture: line[6])

  if product.valid?
    puts "Product #{product.name} created sucessfully."
  else
    puts "Product #{product.name} failed. Errors: #{product.errors}"
  end
end

puts "In Read in products"
# seed Reviews
CSV.foreach('seed_csvs/reviews.csv') do |line|
  review = Review.create(subject: line[0], body: line[1], rating: line[2], user_id: line[3].to_i, product_id: line[4].to_i)
  if review.valid?
    puts "Review #{review.subject} created sucessfully."
  else
    puts "Review #{review.subject} failed. Errors: #{review.errors}"
  end
end
