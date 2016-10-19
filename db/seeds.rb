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
    photo_url: "https://s-media-cache-ak0.pinimg.com/236x/72/77/86/7277863e594b27677d2228101ef7e293.jpg/200/300"
  },
  {
    name: "llama scarf",
    description: "long and warm and not made with other llamas",
    stock: 20,
    price: 1000,
    photo_url: "http://www.yesandyes.org/wp-content/uploads/2011/01/scarf5.jpg/200/300"
  },
  {
    name: "penguin hawaiin shirt",
    description: "For the penguin who wants to get away",
    stock: 4,
    price: 2000,
    photo_url: "https://s-media-cache-ak0.pinimg.com/originals/bf/8a/c8/bf8ac87e3ae2ff56ec7db987edd60d7d.jpg/200/300"
  },
  {
    name: "top hat for dogs",
    description: "For the dog who likes nice things",
    stock: 30,
    price: 500,
    photo_url: "http://2damnfunny.com/wp-content/uploads/2013/12/Classy-Dog-With-a-Fancy-Top-Hat-a-Rich-Mahogany-Smoke-Pipe.png/200/300"
  },
  {
    name: "pigglet dance outfit",
    description: "For the lil piggies who just wanna dance!",
    stock: 12,
    price: 3050,
    photo_url: "http://www.fashionworld.co.uk/blog/wp-content/uploads/2016/01/Cute-Animals-Wearing-Clothes-Pigs-in-Tutus-Playing-Pets-25.jpg/200/300"
  },
  {
    name: "Baby Bunny outfit",
    description: "Are you a new mommy? Dress you little hopper in style!",
    stock: 4,
    price: 1900,
    photo_url: "http://4.bp.blogspot.com/-hZqBuA0W9W8/Uda9I5QVTiI/AAAAAAAABes/Ijk17zrUo-w/s500/tumblr_lsxp1kA2Ks1r4zdm8o1_500.jpg/200/300"
  }
]

product.each do |item|
  Product.create(item)
end
