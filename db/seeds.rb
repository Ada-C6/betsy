# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

product = [
  {
    name: "cat pants",
    description: "a nice pair of slacks with an elastic waist",
    stock: 15,
    price: 850,
    photo_url: "https://s-media-cache-ak0.pinimg.com/236x/72/77/86/7277863e594b27677d2228101ef7e293.jpg"
  },
  {
    name: "llama scarf",
    description: "long and warm and not made with other llamas",
    stock: 20,
    price: 1000,
    photo_url: "http://www.yesandyes.org/wp-content/uploads/2011/01/scarf5.jpg"
  },
  {
    name: "penguin hawaiian shirt",
    description: "For the penguin who wants to get away",
    stock: 4,
    price: 2000,
    photo_url: "https://s-media-cache-ak0.pinimg.com/originals/bf/8a/c8/bf8ac87e3ae2ff56ec7db987edd60d7d.jpg"
  },
  {
    name: "top hat for dogs",
    description: "For the dog who likes nice things",
    stock: 30,
    price: 500,
    photo_url: "http://2damnfunny.com/wp-content/uploads/2013/12/Classy-Dog-With-a-Fancy-Top-Hat-a-Rich-Mahogany-Smoke-Pipe.png"
  },
  {
    name: "piglet dance outfit",
    description: "For the lil piggies who just wanna dance!",
    stock: 12,
    price: 3050,
    photo_url: "http://www.fashionworld.co.uk/blog/wp-content/uploads/2016/01/Cute-Animals-Wearing-Clothes-Pigs-in-Tutus-Playing-Pets-25.jpg"
  },
  {
    name: "Baby Bunny outfit",
    description: "Are you a new mommy? Dress your little hopper in style!",
    stock: 4,
    price: 1900,
    photo_url: "http://4.bp.blogspot.com/-hZqBuA0W9W8/Uda9I5QVTiI/AAAAAAAABes/Ijk17zrUo-w/s500/tumblr_lsxp1kA2Ks1r4zdm8o1_500.jpg"
  }
]

product.each do |item|
  Product.create(item)
end

categories = ["cat", "pants", "llama", "scarves", "penguin", "shirts", "hats", "dogs", "pig", "tutu", "baby", "bunny", "mammals", "birds"]

categories.each do |category|
  Category.create(name: category)
end

all_categories = Category.all
all_products = Product.all


# NOTE: The code below only works for the seed! My seed data has 2 categories per product in the seed. If this seed
# data changes, then this code WILL NOT WORK.
i = 0
j = 0
until i == all_products.size
  product = all_products[i]
  all_products[i].categories << all_categories[j]
  j += 1
  all_products[i].categories << all_categories[j]
  i+=1
  j += 1
end

birds = Category.find_by(name: "birds")
mammals = Category.find_by(name: "mammals")

all_products.each do |item|
  if item.name == "penguin hawaiian shirt"
    item.categories << birds
  else
    item.categories << mammals
  end
end
