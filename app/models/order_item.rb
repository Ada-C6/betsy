class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validate :quantity_not_greater_than_inventory

  private

  def quantity_not_greater_than_inventory
    if quantity == nil || quantity > Product.find(product_id).inventory
      errors.add(:quantity, "Bummer. There are only #{Product.find(product_id).inventory} #{Product.find(product_id).name.pluralize} available.")
    end
  end
end
