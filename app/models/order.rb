class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items
  has_one :payment_detail

  validates :order_status, presence: true
  # TODO: only allow certain pre-defined statuses

  def self.build_order
    return self.new(order_status: "pending")
  end

  def mark_order_paid
    self.order_status = "paid"
    return self
  end

  def cancel_order
    self.order_status = "cancelled"
    return self
  end

  def complete_order
    if self.all_items_shipped?
      self.order_status = "completed"
      self.save
    end
    return self
  end

  def all_items_shipped?
    # when a merchant ships an order item, check if the order can be marked as complete
    self.order_items.each do |item|
      if item.shipped != true
        return false
      end
    end

    return true
  end

  def decrease_products_stock
    self.products.each do |product|
      order_item = product.order_items.where(order_id: self.id).first
      # pass update_quantity a negative number for purchases
      stock_change = order_item.quantity
      product.update_quantity(-stock_change)
    end
  end

  def increase_products_stock
    self.products.each do |product|
      order_item = product.order_items.where(order_id: self.id).first
      stock_change = order_item.quantity
      product.update_quantity(stock_change)
    end
  end



end
