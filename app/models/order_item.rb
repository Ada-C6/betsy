class OrderItem < ActiveRecord::Base
belongs_to :product
belongs_to :order
validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def find_product
    product = Product.find(self.product_id)
    return product
  end
end
