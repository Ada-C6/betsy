class Category < ActiveRecord::Base
  has_many :category_products
  has_many :products, through: :category_products

  validates :name, presence: true, uniqueness: true
end
