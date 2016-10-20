class Product < ActiveRecord::Base
  has_many :product_orders
  has_many :orders, :through => :product_orders

  has_many :product_categories
  has_many :categories, :through => :product_categories

  belongs_to :merchant
  has_many :reviews


  def rating
    total_rating = 0
    if reviews.length != 0
      reviews.each do |review|
        total_rating += review.stars
      end
      return total_rating/reviews.length
      # Do we want the average to round up or down? Should I add one??
    else
      return total_rating
    end
  end

  # def star_string
  #   printed_stars = ""
  #   rating.times {|x| printed_stars << "⭐️"}
  #   return printed_stars
  # end
end
