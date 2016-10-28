class Product < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  has_many :order_items
  has_and_belongs_to_many :categories

  validates :inventory,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0,  }

  validates :price,
    presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 20000}

  validates :name,
    presence: true, uniqueness: true

  def retire
    self.retired = true
  end

  def activate
    self.retired = false
  end

  def in_stock?
    return self.inventory > 0
  end

  def average_rating
    reviews = self.reviews

    if !reviews.blank?
      ratings = reviews.map { |review| !review.rating.blank? ? review.rating.to_f : 0.0 }

      average_rating = ratings.reduce(:+)/ratings.length
    else
      average_rating = 0.0
    end

    return average_rating
  end


  def self.search(query)
    query = "%#{query}%"
    Product.where("name LIKE ? OR description LIKE ?", query, query)
  end

  def self.products_by_rating
    all_products = Product.all
    products_and_ratings = []

    # collect products with their average rating
    all_products.each do |product|
      products_and_ratings << [product, product.average_rating]
    end

    # map the collection of products ordered by their average rating
    desc_sorted_products = products_and_ratings.sort_by { |arr| arr[1] }.map { |arr| arr[0] }.reverse

    return desc_sorted_products
  end
end
