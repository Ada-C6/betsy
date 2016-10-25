class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :order, presence: true
  validates :product, presence: true

  validates :quantity,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }

  validate :must_have_enough_stock

  def subtotal
    self.product.price * self.quantity
  end

  def sufficient_stock?
    return self.product.inventory >= self.quantity
  end

  def must_have_enough_stock
    if self.product.inventory < self.quantity
      errors.add(:stock, "There are only #{self.product.inventory} units of #{self.product.name} left in stock. Please reduce your order quantity and resubmit.")
    end
  end
end
