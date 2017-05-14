class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories

  has_many :transaction_products
  has_many :transactions, through: :transaction_products

  has_many :cart_products
  has_many :carts, through: :cart_products

  has_many :reviews

  belongs_to :user

  validates :name, :unit_price, :quantity, presence: true

  # def average_rating
  # 	return 0 if reviews.count==0
  # 	my_reviews = self.reviews
  # 	sum = my_reviews.inject(0){|sum,review| sum + review.rating}
  # 	return sum/my_reviews.count

  # end

  # def most_popular(products)
  # 	#given an array of product objects, return the one with the highest rating
  # 	#in case of a tie, return the first one found
  # 	return products.sort_by{|product| product.average_rating}.reverse.first
  # end

end
