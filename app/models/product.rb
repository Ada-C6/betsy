class Product < ActiveRecord::Base
  belongs_to :user_id
  has_many :order_id
  has_many :order_item

  def average_rating
    reviews = Review.where(:product_id => self.id)
    return reviews.average(:rank)
  end
end
