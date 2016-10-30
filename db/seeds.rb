# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

bob = Merchant.create(username: "bob1", uid: 121413, provider: 'github', email: "bob@bobness.com", displayname: "Bob's Wondrous Wares")
jane = Merchant.create(username: "jane1", uid: 2445, photo: 'uni_pillow.png', provider: 'github', email: "jane@janesworld.com", displayname: "Jane's Unicorny Delights")

CSV.foreach('seed_csvs/unicorn_items.csv', :headers => false) do |csv_obj|
  product = Product.new(name: csv_obj[0], description: csv_obj[1], price: csv_obj[2].to_i, stock: csv_obj[3].to_i, retired: csv_obj[5], photo: csv_obj[6].to_s)
  Merchant.find(rand(1..2)).products << product
  product.save
end


#=========PLACEHOLDER TESTING SEEDS (NOT SUITABLE FOR FINAL SITE)=========================#

Category.create(name: "Unicorny goodness")
Category.create(name: "Awesome unicorn gear")
Category.create(name: "Unicorn top picks")

def pick_cat

  roll = rand(1..3)

  if roll == 1
    return Category.find(1)
  elsif roll == 2
    return Category.find(2)
  else
    return Category.find(3)
  end

end

# puts "GOT HERE"

Product.all.each do |product|
  product.update(merchant_id: rand(1..2))
  pick_cat.products << product
  # puts "Added #{product.name} to category"
end
