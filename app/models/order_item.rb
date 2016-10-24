class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  def total_price
    return self.unit_price * self.quantity
  end
end
