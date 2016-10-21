class Order < ActiveRecord::Base
    has_many :order_items

    validates :cc_number, presence: true, numericality: {only_integer: true}, length: { is: 16 }
    validates :cc_exp_year, presence: true, length: {is: 4}
    validates :cc_exp_month, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12}
    validates :total, presence: true, numericality: { greater_than_or_equal_to: 0}
    validate :valid_exp
    validates_associated :order_items
    validate :acceptable_status

    before_create :set_order_status
    before_save :update_total

    def valid_exp
        if cc_exp_year < Time.now.year
            errors.add(:cc_exp_year, "Card year is expired")
        elsif cc_exp_year == Time.now.year && cc_exp_month < Time.now.month
            errors.add(:cc_exp_month, "Card month is expired")
        end
    end

    def acceptable_status
        if status != "PENDING" && status != "PAID" && status != "COMPLETE" && status != "CANCELLED"
            errors.add(:status, "Must be PENDING, PAID, COMPLETE or CANCELLED")
        end
    end

    def total
        order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.product.price) : 0 }.sum
    end

    private
    def set_order_status
        self.status = "PENDING"
    end

    def update_total
        self[:total] = total
    end
end
