class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, numericality: {greater_than: 0}

  def self.add_order_item_to_order(this_order_id, this_product_id)
    order_item = self.new(quantity: 1)
    order_item.order_id = this_order_id
    order_item.product_id = this_product_id
    return order_item
  end

  def self.sum_total_prices(order_items_collection)
    return 0 if order_items_collection.nil?

    sum = 0
    order_items_collection.each do |item|
      product = item.product
      quantity = item.quantity
      price = product.price
      sum  += quantity * price
    end
    return sum
  end

end
