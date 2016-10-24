class Product < ActiveRecord::Base
  belongs_to :user
  has_many :orders
  has_many :order_items, through: :orders

  def average_rating
    reviews = Review.where(:product_id => self.id)
    return reviews.average(:rank)
  end


private
  def self.random_photo(wanted_category)
  	Product.where(category: wanted_category).sample.photo_url
  end
end
