class Order < ActiveRecord::Base
  has_many :orderitems

  validates :orderitems,
            presence: true

  def total
    total = 0

    self.orderitems.each do |orderitem|
      total += orderitem.total
    end

    return total
  end

  def has_product (product_id)

    self.orderitems.each do |orderitem|
      if orderitem.product.id == product_id
        return true
      end
    end

    return false

  end

  # Reduce the stock of each item when it is sold

  def update_stock

    self.orderitems.each do |orderitem|
      product = orderitem.product
      product.stock -= orderitem.quantity
      product.save
    end

  end

  def remove_backordered?
    there_are_backordered_items = false
    self.orderitems.each do |orderitem|
      product = orderitem.product
      if product.stock <= 0 # If an item is fully out of stock, remove it from the cart
        if self.orderitems.length == 1
          self.destroy
        end
        orderitem.destroy
        there_are_backordered_items = true
      elsif product.stock < orderitem.quantity  # If an item has too little stock to fill the order fully, reduce the quantity
        orderitem.quantity = product.stock
        orderitem.save
        there_are_backordered_items = true
      end
    end
    return there_are_backordered_items
  end

end
