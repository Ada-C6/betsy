# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

  CSV.foreach ('seed_csvs/products.csv') do |csv_obj|
    Product.create(name: csv_obj[1], description: csv_obj[2], price: csv_obj[3], photo_url: csv_obj[4], inventory: csv_obj[5], category: csv_obj[6], user_id: csv_obj[7])
  end

  CSV.foreach ('seed_csvs/users.csv') do |csv_obj|
    User.create(first_name: csv_obj[1], last_name: csv_obj[2], email: csv_obj[3], street_address: csv_obj[4], city: csv_obj[5], state: csv_obj[6], zip: csv_obj[7], phone: csv_obj[8], merchant: csv_obj[9], provider: csv_obj[10])
  end
