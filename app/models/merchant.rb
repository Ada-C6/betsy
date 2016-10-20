class Merchant < ActiveRecord::Base
  has_many :products
  has_many :orders
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def revenue_paid_orders
    revenue_total = 0.0
    orders.each do |order|
      revenue_total += order.total_amount
    end
    return revenue_total
  end

  # def orders_count
  #   total_orders = 0
  #   orders.
  # end
end
