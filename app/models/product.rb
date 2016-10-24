class Product < ActiveRecord::Base
  has_many :orderitems
  has_many :reviews
  has_many :ordered_products
  has_many :categories, through: :ordered_products
  belongs_to :merchant

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true
  validates :photo_url, presence: true

  def self.find_photo_image(product)
    if product.photo_url == nil
      image = "#{ product.name.downcase.gsub(' ', '_') }.jpeg"
    else
      image = product.photo_url
    end
    return image
  end

  def self.search(search)
    where(("name LIKE ? OR description LIKE ? OR category LIKE ?"), "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
