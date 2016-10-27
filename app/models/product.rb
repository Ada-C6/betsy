class Product < ActiveRecord::Base
  belongs_to :user
  has_many :orders
  has_many :order_items, through: :orders
  validates :name, presence: true
  validates :price, presence: true
  validates :price, numericality: {greater_than: 0 }
  #, format: { :with => /\A\d+(?:\.\d{0,2})?\z/ }
  validates :category, presence: true 


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
