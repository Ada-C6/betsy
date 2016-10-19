require 'csv'

CSV.read('seed_csvs/products.csv').each do |line|
  product_hash = { name: line[0], price: line[1].to_i, merchant_id: line[2].to_i}
  Product.create(product_hash)
end
