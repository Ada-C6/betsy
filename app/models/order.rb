class Order < ActiveRecord::Base
  has_many :order_items
  has_many :products, through: :order_items

  def items_in_order
    self.order_items # returns collection of items in this order
  end

  def total
    total = 0

    items_in_order.each do |item|
      total += (item.find_product.price * item.quantity)
    end

    return total
  end

  def mark_as_paid
    self.status = "paid"
    self.save
  end

  def mark_as_shipped
    self.status = "shipped"
    self.save
  end
end
