class Product < ActiveRecord::Base
  belongs_to :user_id
  has_many :order_id
  has_many :order_item

  def average_rating
    product = Product.find(pramas[:id].to_i)
    reviews = Review.where(product.id)
    return reviews.average(:rank)
  end
end
