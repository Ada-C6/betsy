# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
merchants = [
    {
        user_name: "SSBinks",
        uid: 16868372,
        provider: "github",
        email: "smeggs1@gmail.com",
        id: 1
    },
    {
        user_name: "sckirk",
        uid: 17997728,
        provider: "github",
        email: "skirk.seattle@gmail.com",
        id: 2
    },
    {
        user_name: "johnanmorris",
        uid: 10949311,
        provider: "github",
        email: "johna.n.morris@gmail.com",
        id: 3
    },
    {
        user_name: "yenicapotediaz",
        uid: 17466680,
        provider: "github",
        email: "yenicapote08@gmail.com",
        id: 4
    }
]

merchants.each do |merchant|
  Merchant.create(merchant)
end


products = [
  {
    name: "cat pants",
    description: "a nice pair of slacks with an elastic waist",
    stock: 15,
    price: 850,
    photo_url: "https://s-media-cache-ak0.pinimg.com/236x/72/77/86/7277863e594b27677d2228101ef7e293.jpg",
    merchant_id: 1
  },
  {
    name: "dog booties",
    description: "a nice pair of slacks with an elastic waist",
    stock: 40,
    price: 2026,
    photo_url: "http://s7d1.scene7.com/is/image/PETCO/2410644-center-1?$ProductList-medium$",
    merchant_id: 1
  },
  {
    name: "santa gp",
    description: "For the guinea pig who loves cookies and milk!",
    stock: 90,
    price: 1886,
    photo_url: "http://i.huffpost.com/gadgets/slideshows/318566/slide_318566_2975396_free.jpg",
    merchant_id: 1
  },
  {
    name: "Pirate Pig",
    description: "rrrrrrr, matey! Oink!",
    stock: 40,
    price: 8678,
    photo_url: "http://www.whenpigsflynaked.com/uploads/1/1/9/8/11981007/2001761.jpg?276",
    merchant_id: 1
  },
  {
    name: "llama scarf",
    description: "long and warm and not made with other llamas",
    stock: 20,
    price: 1000,
    photo_url: "http://www.yesandyes.org/wp-content/uploads/2011/01/scarf5.jpg",
    merchant_id: 2
  },
  {
    name: "Freddy the Frog - pig",
    description: "for the pig who longs to be a frog",
    stock: 200,
    price: 4898,
    photo_url: "https://s-media-cache-ak0.pinimg.com/236x/82/cf/6a/82cf6a68cb2a7ee1ecf461efcb445a78.jpg",
    merchant_id: 2
  },
  {
    name: "pig hoodie",
    description: "comfortable fleece-lined hoodie for your mini pig",
    stock: 88,
    price: 4204,
    photo_url: "http://66.media.tumblr.com/tumblr_m0h5qg83CY1rr5f7co1_500.jpg",
    merchant_id: 2
  },
  {
    name: "hedgehog bagpipes",
    description: "For your hedgehog who loves to Scottish jigs",
    stock: 20,
    price: 2695,
    photo_url: "https://s-media-cache-ak0.pinimg.com/564x/29/8c/a4/298ca4654d55ffbe01aa4afa3a9e66c8.jpg",
    merchant_id: 2
  },
  {
    name: "pumpkin gp",
    description: "this little piggy is ready to go trick-or-treating",
    stock: 60,
    price: 1995,
    photo_url: "http://s.marketwatch.com/public/resources/MWimages/MW-BN838_pfpets_MG_20131024180004.jpg",
    merchant_id: 2
  },
  {
    name: "penguin hawaiian shirt",
    description: "For the penguin who wants to get away",
    stock: 4,
    price: 2000,
    photo_url: "https://s-media-cache-ak0.pinimg.com/originals/bf/8a/c8/bf8ac87e3ae2ff56ec7db987edd60d7d.jpg",
    merchant_id: 2
  },
  {
    name: "beaver pipes",
    description: "For the beaver who's roots are in Scotland",
    stock: 26,
    price: 2804,
    photo_url: "https://s-media-cache-ak0.pinimg.com/236x/e1/36/a7/e136a71ba59f26a4f47bb6e34d2129b5.jpg",
    merchant_id: 3
  },
  {
    name: "stylish puffy jacket",
    description: "For the dog who gets a little chilly",
    stock: 26,
    price: 48000,
    photo_url: "http://www.dogsmartway.com/upload/product_ad_1881.jpg",
    merchant_id: 3
  },
  {
    name: "walk the plank",
    description: "For the cat who's always in charge",
    stock: 40,
    price: 6000,
    photo_url: "https://d8s0dvdlqz4n8.cloudfront.net/wp-content/uploads/2015/03/Pirate-Cat-Costume1.jpg",
    merchant_id: 3
  },
  {
    name: "active stripes",
    description: "For the dog who can't wait to hit the track",
    stock: 80,
    price: 2200,
    photo_url: "https://img0.etsystatic.com/138/0/10819873/il_570xN.1019173514_9lsr.jpg",
    merchant_id: 3
  },
  {
    name: "top hat for dogs",
    description: "For the dog who likes nice things",
    stock: 30,
    price: 500,
    photo_url: "http://2damnfunny.com/wp-content/uploads/2013/12/Classy-Dog-With-a-Fancy-Top-Hat-a-Rich-Mahogany-Smoke-Pipe.png",
    merchant_id: 3
  },
  {
    name: "Pig Cowboy Hat",
    description: "Yeehawg! Get along, lil piggy!",
    stock: 20,
    price: 400,
    photo_url: "https://67.media.tumblr.com/tumblr_m8bbiv8kil1r9uia2o1_1280.jpg",
    merchant_id: 3
  },
  {
    name: "piglet dance outfit",
    description: "For the lil piggies who just wanna dance!",
    stock: 12,
    price: 3050,
    photo_url: "http://www.fashionworld.co.uk/blog/wp-content/uploads/2016/01/Cute-Animals-Wearing-Clothes-Pigs-in-Tutus-Playing-Pets-25.jpg",
    merchant_id: 3
  },
  {
    name: "weiner dog bobsled",
    description: "For the dog who craves speed and adventure",
    stock: 12,
    price: 36800,
    photo_url: "http://cdn3-www.dogtime.com/assets/uploads/gallery/wiener-dog-halloween-costumes/8-wiener-dog-bobsled-team.jpg",
    merchant_id: 3
  },
  {
    name: "Nyan Cat",
    description: "A pop tart cat inspired costume for your cat to nyan around the house in. Made out of materials that won't harm your pet and safe to lay in as well.",
    stock: 150,
    price: 5000,
    photo_url: "https://img0.etsystatic.com/139/0/10302358/il_570xN.1030148796_77jh.jpg",
    merchant_id: 4
  },
  {
    name: "Aye aye Captain",
    description: "For the cat who longs to be at sea.",
    stock: 60,
    price: 1800,
    photo_url: "http://www.momdoesreviews.com/wp-content/uploads/2015/10/Sailor-Dog-Cat-Costume.jpg",
    merchant_id: 4
  },
  {
    name: "Minnie Pig",
    description: "For the pig who dreams of the magical land!",
    stock: 40,
    price: 11800,
    photo_url: "http://i.mobofree.com/?u=http%3A%2F%2Flostininternet.com%2Fwp-content%2Fuploads%2F2014%2F10%2FPoppy-and-priscilla-piglets-01.jpg&w=600&h=1500",
    merchant_id: 4
  },
  {
    name: "Baby Bunny outfit",
    description: "Are you a new mommy? Dress your little hopper in style!",
    stock: 4,
    price: 1900,
    photo_url: "http://4.bp.blogspot.com/-hZqBuA0W9W8/Uda9I5QVTiI/AAAAAAAABes/Ijk17zrUo-w/s500/tumblr_lsxp1kA2Ks1r4zdm8o1_500.jpg",
    merchant_id: 4
  }
]

products.each do |item|
  Product.create(item)
end



categories = ["pants", "booties", "santa", "pirate", "scarves", "frog", "hoodies", "bagpipes", "pumpkin", "shirts", "beaver", "jackets", "cat", "track suits", "hats", "cowboy hats", "tutus", "bobsleds", "nyan", "sailors", "minnie mouse", "bunny", "mammals", "birds"]

# categories = ["cat", "pants", "dog", "booties", "santa", "guinea pig", "pirate", "pig", "llama", "scarves", "frog", "pig", "pig", "hoodies", "hedgehog", "bagpipes", "pumpkin", "guinea pig", "penguin", "shirts", "beaver", "bagpipes", "dog", "jackets", "pirate", "cat", "dog", "track suits", "hats", "dog", "pig", "cowboy hats", "pig", "tutus", "dog", "bobsleds", "nyan", "cat", "cat", "sailors", "pig", "minnie mouse", "baby", "bunny", "mammals", "birds"]

categories.each do |category|
  Category.create(name: category)
end

# My apologies Noelle, I'm adding in more seed product data, so that our views look more robust for our Friday demo.

all_categories = Category.all
all_products = Product.all


# NOTE: The code below only works for the seed! My seed data has 2 categories per product in the seed. If this seed
# data changes, then this code WILL NOT WORK.
i = 0
j = 0
until i == all_products.size
  product = all_products[i]
  all_products[i].categories << all_categories[j]
  # j += 1
  # all_products[i].categories << all_categories[j]
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
