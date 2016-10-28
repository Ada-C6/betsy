class Category < ApplicationRecord
  has_many :products, through: :categories_products
  has_many :categories_products

  validates :name, presence: true, uniqueness: true
end
