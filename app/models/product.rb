class Product < ActiveRecord::Base
  has_many :reviews
  belongs_to :merchant

  has_many :order_items
  has_many :orders, :through => :order_items

  has_many :product_categories
  has_many :categories, :through => :product_categories

  validates :name, presence: true, uniqueness: true

  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }

  # I think that we should make sure that a product has at least one category? We can discuss.

  validates :categories, :length => { :minimum => 1 }

  validates :merchant, :presence => true

  # Same here - I think this is important to have validated (cannot have negative stock.)
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
