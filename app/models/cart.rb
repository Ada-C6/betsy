class Cart < ActiveRecord::Base
  has_many :cart_products
  has_many :products, through: :cart_products
end
