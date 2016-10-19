class OrderItem < ActiveRecord::Base
    validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
    # less_than_or_equal_to: Product.find(self.product_id).quantity }
    # I'd like this last line of code to work in the numericality hash--it's not working right now. Maybe it will work once the Product model has been created in this version of our app?
    # Also, need to confirm what the quantity/stock variable is in the Product model and update the last word of this commented out code in line 3.
    validates :product_id, presence: true
    validates :order_id, presence: true
    validates :shipped?, presence: true

    belongs_to :product
    belongs_to :order
end
