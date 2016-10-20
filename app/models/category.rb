class Category < ActiveRecord::Base
  has_many :ordered_products
  has_many :products, through: :ordered_products

  validates :name, presence: true, uniqueness: true
end
