class CartProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
end
