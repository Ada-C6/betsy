class Order < ActiveRecord::Base
  has_many :line_items
  # has_many :product_orders
  has_many :products, :through => :line_items
  belongs_to :merchant
  belongs_to :guest

  def add_product(product, qty)
#if there is a guest and a cart
  #add a row to the LineItem table
  #once the line is added return the user back to the product page
    line = LineItem.new
    line.product = product
    line.merchant_id = product.merchant_id
    line.qty = qty
    line.price = product.price
    line_items << line
  end

  def total_amount
    total = 0
    self.line_items.each do |line|
      line.subtotal
      total += line.subtotal
  end
    return total
  end

end
