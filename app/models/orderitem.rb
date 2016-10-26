class Orderitem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validates :quantity,
            numericality: { only_integer: true, greater_than: 0 }

  validates :product,
            presence: true

  validates :order,
            presence: true

  def total
    return self.quantity * self.product.price
  end

  def price
    return self.product.price
  end
  
end
