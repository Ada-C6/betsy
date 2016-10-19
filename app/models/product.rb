class Product < ActiveRecord::Base
  has_many :product_orders
  has_many :orders, :through => :product_orders

  has_many :product_categories
  has_many :categories, :through => :product_categories

  belongs_to :merchant
  has_many :reviews
end
