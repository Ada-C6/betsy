class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :product, presence: true
  # validates_inclusion_of :product_id, :in => Product.all.pluck(:id)
  validates :order, presence: true
end
