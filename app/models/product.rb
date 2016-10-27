class Product < ActiveRecord::Base
  has_many :orderitems
  has_many :reviews
  has_many :category_products
  has_many :categories, through: :category_products
  belongs_to :merchant

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true
  validates :photo_url, presence: true

  def self.find_photo_image(product)
    if product.photo_url == "1"
      image = "#{ product.name.downcase.gsub(' ', '_') }.jpeg"
    else
      image = product.photo_url
    end
    return image
  end

  def self.search(search)
    where(("name LIKE ? OR description LIKE ?"), "%#{search}%", "%#{search}%")
  end

  def self.average(reviews)
    ratings = []
    num_ratings = reviews.count
    reviews.each do |i|
      ratings << i[:rating]
    end
    average = (ratings.sum)/num_ratings.to_f
    return sprintf('%.1f' % average)
  end
end
