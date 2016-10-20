class Order < ActiveRecord::Base
  has_many :product_orders
  has_many :products, :through => :product_orders
  has_many :line_items
  belongs_to :merchant
  belongs_to :guest
end
