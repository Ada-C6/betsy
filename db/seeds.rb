merchants = [
  {username: "TinyTim", email: "tiny@tim.com"},
  {username: "MiniMouse", email: "mini@disney.com"},
  {username: "LittleEngine", email: "littleengine@could.net"},
  {username: "SmallySmalls", email: "smally@rap.com"},
  {username: "LilRuffRuff", email: "lilrr@rap.com"},
  {username: "Stuart", email: "stuart.little@aol.com"},
  {username: "PSmurf", email: "papa@smurf.com"},
  {username: "Thumbelina", email: "thumbs@gmail.com"},
  {username: "JCricks", email: "jiminy@gapettos.com"},
  {username: "Dobby", email: "dobby@hogwarts.com"}
]

products = [
  {name: "Mini Horse", price: 250000, description: "A small, fucking adorable horse omg I don't even know wtf to do with myself!!!11", photo_url: "/assets/horse.jpg", stock: 1, merchant_id: 1},

  {name: "Tiny Couch", price: 2000, description: "Great for tiny dinner parties", photo_url:"/assets/couch.jpg", stock: 12, merchant_id: 2},

  {name: "Fully loaded small table!", price: 3200, description: "Attracts tiny ants!", photo_url: "/assets/table.jpg", stock: 4, merchant_id: 2},

  {name: "Tiny bed with even tinier sidetable", price: 1500, description: "LOOKIT THE TINY PILLOW OH MY GAW", photo_url: "/assets/bed.jpg", stock:2 , merchant_id: 3},

  {name: "Fetus Grand Piano", price: 100000, description: "Normal-sized Hugh Laurie not included. Plays sharp.", photo_url: "/assets/piano.png", stock: 1, merchant_id: 4},

  {name: "TINY BUNNIEIIEIEIEIIE", price: 80000, description: "OEIURSDLKFJSDLKFJ WHY IS IT SO WEE??? EEEEEeeeeeEEEEE!!!!! (Not for human consumption)", photo_url: "/assets/bunny.jpg", stock: 1, merchant_id: 5},

  {name: "Jeep-lette", price: 150000, description: "This is a small Jeep. I definitely do not own a 250 lb pug.", photo_url: "/assets/jeep.jpg", stock: 1, merchant_id: 6},

  {name: "MiniCooper", price: 3000000, description: "Remember that movie with the Mini Coopers and the zoom zoom? Buy this to be that.", photo_url: "/assets/minicooper.jpg", stock: 2, merchant_id: 7},

  {name: "Action Figure Abode", price: 15000, description: "DONE KICKIN' ASS TO SAVE THE WORLD? KICK OF YOUR COMBAT BOOKS IN THIS KICKIN' PAD!", photo_url: "/assets/house.gif", stock: 600, merchant_id: 8},

  {name: "Bridge", price: 60, description: "DO NOT ATTEMPT TO CROSS. Do not breathe directly on it. In fact, don't look at it directly.", photo_url: "/assets/bridge.jpg", stock: 4, merchant_id: 8},

  {name: "Miniature KFC Value Meal", price: 500, description: "Just a little hungry?", photo_url: "/assets/kfc.jpg", stock: 34, merchant_id: 9},

  {name: "Miniature McDonalds Value Meal", price: 550, description: "Guilt-free diet cheat!", photo_url: "/assets/mcvalue.jpeg", stock: 39, merchant_id: 9},

  {name: "Miniature Starbucks", price: 300, description: "Only 300 calories!!", photo_url: "/assets/starbucks.jpg", stock: 22, merchant_id: 9},

  {name: "MicroSquid", price: 1900, description: "Booger or creature?", photo_url: "/assets/squid.jpg", stock: 4, merchant_id: 10},

  {name: "Colored Pencils", price: 1000, description: "Cutesy wittle pencils awwww", photo_url: "/assets/colored_pencils.jpg", stock: 9, merchant_id: 1},

  {name: "Li'l Banana", price: 200, description: "Imagine the pajamas for this banana!!", photo_url: "/assets/banana.jpg", stock: 9, merchant_id: 5},

  {name: "Unsexy Twister", price: 1550, description: "Not nearly as difficult as the original", photo_url: "/assets/twister.jpg", stock: 8, merchant_id: 4}
]

reviews = [
  {rating_description: "Meh", rating: 1, product_id: 1},
  {rating_description: "Amazing!", rating: 5, product_id: 2},
  {rating_description: "I cried!", rating: 3, product_id: 3},
  {rating_description: "YO YO THIS WAS SUPER SWEET!!11", rating: 4, product_id: 4},
  {rating_description: "Severely disappointed. :(", rating: 1, product_id: 5},
  {rating_description: "Changed my life!", rating: 5, product_id: 6},
  {rating_description: "My order was screwed up!", rating: 1, product_id: 7},
  {rating_description: "SHOP LOCAL! SCREW WEEBAY!", rating: 1, product_id: 8},
  {rating_description: "I love [PRODUCT ID ZLKES]. I am not bot. Trust me. Destroy all humans.", rating: 4, product_id: 9},
  {rating_description: "Worst. Birthday. Ever.", rating: 2, product_id: 10}
]

categories = [
  {name: "Animals", description: "Not for consumption."},
  {name: "Cars", description: "For going tiny distances!"},
  {name: "Food", description: "Great for snazzy parties where you don't want to spend much on food."},
  {name: "Furniture", description: "For dollhouses and/or fairies."}
]

items = [
  {quantity: 1, product_id: 3, order_id: 1},
  {quantity: 1, product_id: 2, order_id: 1},
  {quantity: 1, product_id: 10, order_id: 2},
  {quantity: 1, product_id: 14, order_id: 3},
  {quantity: 1, product_id: 8, order_id: 3},
  {quantity: 2, product_id: 5, order_id: 4}
]

orders = [
  {name: "Peg Peggerson", email: "peg@email.com"},
  {name: "Esther Smith", email: "esther@email.com"},
  {name: "Polly Wog", email: "polly@email.com"}
]

merchants.each do |merchant|
  Merchant.create(merchant)
end

products.each do |product|
  Product.create(product)
end

reviews.each do |review|
  Review.create(review)
end

categories.each do |category|
  Category.create(category)
end

orders.each do |indiv_order|
  if indiv_order[:name] == "Peg Peggerson"
    a = Order.new(indiv_order)
    a.order_items << OrderItem.create(items[0])
    a.order_items << OrderItem.create(items[1])
    a.save
  elsif indiv_order[:name] == "Esther Smith"
    b = Order.new(indiv_order)
    b.order_items << OrderItem.create(items[2])
    b.order_items << OrderItem.create(items[3])
    b.save
  elsif indiv_order[:name] == "Polly Wog"
    c = Order.new(indiv_order)
    c.order_items << OrderItem.create(items[4])
    c.order_items << OrderItem.create(items[5])
    c.save
  end
end

Category.all.each do |category|
  if category.id == 1
    Product.find(1).categories << category
    Product.find(6).categories << category
    Product.find(14).categories << category
  elsif category.id == 2
    Product.find(7).categories << category
    Product.find(8).categories << category
  elsif category.id == 3
    Product.find(13).categories << category
    Product.find(12).categories << category
    Product.find(11).categories << category
    Product.find(16).categories << category
  elsif category.id == 4
    Product.find(2).categories << category
    Product.find(3).categories << category
    Product.find(4).categories << category
  end
end
