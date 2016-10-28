class Guest < ActiveRecord::Base
  has_many :orders
  has_many :line_items

  def cart
    #find cart from guest orders
    self.orders.find_or_create_by(:order_status => "pending")
    #if not found we create it
    #guest has one cart
    #the cart is an orders
    #the guest has_many orders
    #has to be pending orders
    #return the cart
  end

  

end
