class Product < ActiveRecord::Base
  belongs_to :user
  has_many :orders
  has_many :order_items, through: :orders
  has_many :reviews
  
  validates :name, :description, :category, presence: true

  validates :price, presence: true, numericality: {:greater_than => 0}

  validates :inventory, presence: true, numericality: {:greater_than_or_equal_to => 0}




  def average_rating
    reviews = Review.where(:product_id => self.id)
    return reviews.average(:rank)
  end

  private
  def self.random_photo(wanted_category)
  	Product.where(category: wanted_category).sample.photo_url
  end

  def self.search(query)
    where("name LIKE ? OR description LIKE ?", "%#{query}%", "%#{query}%")
  end

end
