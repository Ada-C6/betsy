require 'csv'

CSV.read('db/seed_csvs/all_products.csv').each do |line|
  product_hash = { merchant_id: line[0].to_i, name: line[1], price: line[2].to_i, category: line[3].to_i, inventory: line[4], description: line[5] }
  Product.create(product_hash)
end
