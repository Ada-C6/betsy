class Order < ActiveRecord::Base
  has_many :order_items
  validates :cc_number, presence: true, numericality: {only_integer: true}, length: { is: 16 }
  validates :cc_exp_year, presence: true, length: {is: 4}
  validates :cc_exp_month, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12}
  validate :valid_exp

  def valid_exp
    if cc_exp_year < Time.now.year
      errors.add(:cc_exp_year, "Card year is expired")
    elsif cc_exp_year == Time.now.year && cc_exp_month < Time.now.month
      errors.add(:cc_exp_month, "Card month is expired")
    end
  end
end
