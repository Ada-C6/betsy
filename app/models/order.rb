class Order < ActiveRecord::Base
  has_many :order_items

  validates :cc_number, presence: true, numericality: {only_integer: true}, length: { is: 4 }
  validates :cc_exp_year, presence: true, length: {is: 4}
  validates :cc_exp_month, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12}
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0}
  # validate :valid_exp
  validates_associated :order_items
  # validate :acceptable_status

  before_save :update_total

  def valid_exp
    if @order.cc_exp_year < Time.now.year
      errors.add(:cc_exp_year, "Card year is expired")
    elsif @order.cc_exp_year == Time.now.year && @order.cc_exp_month < Time.now.month
      errors.add(:cc_exp_month, "Card month is expired")
    end
  end

  def acceptable_status
    if @order.status != "PENDING" && @order.status != "PAID" && @order.status != "COMPLETE" && @order.status != "CANCELLED"
      errors.add(:status, "Must be PENDING, PAID, COMPLETE or CANCELLED")
    end
  end

  def update_total
    total = 0
    order_items.each do |item|
      product = item.product
      total += product.price
    end
    self.total = total
  end


end
