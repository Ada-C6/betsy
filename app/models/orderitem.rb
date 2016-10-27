class Orderitem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validates :quantity,
            numericality: { only_integer: true, greater_than: 0 }

  validates :product,
            presence: true

  validates :order,
            presence: true

  validates :price,
            presence: true

  def total
    return self.quantity * self.price
  end

end
