class OrderItem < ActiveRecord::Base
    belongs_to :product
    belongs_to :order

    validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
    validates :product_id, presence: true
    validates :order_id, presence: true
    validates :shipped?, inclusion: { in: [true, false] }
    validate :valid_quantity

    def total_price
        self.product.price * quantity
    end

    private
    def valid_quantity
        return false if quantity.nil?
        return false if self.product.nil?
        if quantity > self.product.stock
            errors.add(:quantity, "there is not enough stock of this product to fulfill your request, please try again")
        end
    end
end
