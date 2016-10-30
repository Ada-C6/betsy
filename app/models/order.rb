class Order < ActiveRecord::Base
  has_many :orderitems

  validates :orderitems,
            presence: true

  scope :status, lambda{|status| where('status = ?', status )}

  # Email validation from: http://api.rubyonrails.org/classes/ActiveModel/Validations/ClassMethods.html
  validates :name, presence: true, if: :buyer_info_needed?
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, if: :buyer_info_needed?
  validates :address, presence: true, if: :buyer_info_needed?
  validates :city, presence: true, if: :buyer_info_needed?
  validates :state, presence: true, if: :buyer_info_needed?
  validates :zip, presence: true, numericality: true, length: {minimum: 5, maximum: 5}, if: :buyer_info_needed?
  validates :card_name, presence: true, if: :buyer_info_needed?
  validates :card_num, presence: true, numericality: true, length: {minimum: 13, maximum: 19}, if: :buyer_info_needed?
  validates :expiry, presence: true, if: :buyer_info_needed?
  validates :cvv, presence: true, numericality: true, length: {minimum: 3, maximum: 4}, if: :buyer_info_needed?
  validates :billing_zip, presence: true, numericality: true, length: {minimum: 5, maximum: 5}, if: :buyer_info_needed?
  validates :placed_at, presence: true, if: :buyer_info_needed?


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

  #update stock when order is canceled, ONLY for items specified merchant was responsible for.
  def update_cancel_stock

    self.orderitems.each do |orderitem|
      if orderitem.status != "Shipped"
        product = orderitem.product
        product.stock += orderitem.quantity
        product.save
      end
    end

  end


  def find_merchant_order_items(user_id)
    orderitems = []
    self.orderitems.each do |orderitem|
      if orderitem.product.merchant_id == user_id.to_i
        orderitems << orderitem
      end
    end
    return orderitems
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

  def destroy_items
    self.orderitems.each do |orderitem|
      orderitem.destroy
    end
  end

  def update_prices?
    there_are_updated_prices = false
    self.orderitems.each do |orderitem|
      product = orderitem.product
      if orderitem.price != product.price # If an item's price has changed
        orderitem.update(price: product.price)
        there_are_updated_prices = true
      end
    end
    return there_are_updated_prices
  end

  private

  def buyer_info_needed?
    return status == 'paid'
  end
end
