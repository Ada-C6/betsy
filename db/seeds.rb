require 'csv'

CSV.read('db/seed_csvs/products.csv').each do |line|
  product_hash = { merchant_id: line[0].to_i, name: line[1], price: line[2].to_f, inventory: line[4], description: line[5], photo_url: "1", active: true }
  Product.create!(product_hash)
end

CSV.read('db/seed_csvs/categories.csv').each do |line|
  category_hash = { name: line[0] }
  Category.create!(category_hash)
end

CSV.read('db/seed_csvs/categoryproducts.csv').each do |line|
  category_product_hash = { product_id: line[0], category_id: line[1] }
  CategoryProduct.create!(category_product_hash)
end
