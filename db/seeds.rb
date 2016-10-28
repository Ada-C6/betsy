# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

  CSV.foreach ('seed_csvs/products.csv') do |csv_obj|
    Product.create(name: csv_obj[1], description: csv_obj[2], price: csv_obj[3].to_f, photo_url: csv_obj[4], inventory: csv_obj[5].to_i, category: csv_obj[6], user_id: csv_obj[7].to_i, alt_text: csv_obj[8])
  end

  CSV.foreach ('seed_csvs/users.csv') do |csv_obj|
    User.create(name: csv_obj[1], email: csv_obj[2], street_address: csv_obj[3], city: csv_obj[4], state: csv_obj[5], zip: csv_obj[6].to_i, phone: csv_obj[7], merchant: csv_obj[8], provider: csv_obj[9])
  end
