class PaymentDetail < ActiveRecord::Base
  belongs_to :order

    #TODO: create tests related to credit card number.

    before_validation(on: :create) do
      cc_long_enough?
      if valid_cc_number?
        set_cc_four_digits
      end
    end

    validates :buyer_name, presence: true
    validates :email, presence: true
      # REGEX to validate format of email is ---@---.---
    validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

    validates :street, presence: true
    validates :city, presence: true
    validates :state, presence: true
      # US Zip for MA is min: 1001, AK is max: 99950
    validates :zip, presence: true, numericality: { greater_than: 1000,  less_than: 99951, only_integer: true }

    validates :cc_four_digits, presence: true, length: { is: 4 }
    validates :cc_expiration_date, presence: true
    validate :expiration_date_cannot_be_in_the_past

    validates :time_placed, presence: true

    # validates :CVV, presence: true, length: {is: 3}

    def record_time_placed
      self.time_placed = Time.now
    end

    def set_order_id(this_order_id)
      self.order_id = this_order_id
    end

  private

  #### EXPIRATION DATE ####

    def expiration_date_cannot_be_in_the_past
      if self.cc_expiration_date == nil
        errors.add(:cc_expiration_date, "can't be nil")
      elsif self.cc_expiration_date <= Time.now
        errors.add(:cc_expiration_date, "can't be in the past")
      end
    end


  #### FOR CREDIT CARD NUMBER ####

    # Visa, MasterCard, Amex have 13-16 digits
    def cc_long_enough?
      digits = self.cc_four_digits.to_s.length
      errors.add(:cc_four_digits, 'Sorry, the card number must be between 13 and 16 digits') unless digits.between?(13,16)
    end

    # Luhn from: http://en.wikipedia.org/wiki/Luhn_algorithm
    # 1. From the rightmost digit, which is the check digit, moving left, double the value of every second digit; if product of this doubling operation is greater than 9 (e.g., 7 * 2 = 14).
    # 2. Sum the digits of the products (e.g., 10: 1 + 0 = 1, 14: 1 + 4 = 5) together with the undoubled digits from the original number.
    # 3. If the total modulo 10 is equal to 0 (if the total ends in zero) then the number is valid according to the Luhn formula; else it is not valid.

    # Returns true or false
    def valid_cc_number?
      #remove non-digits and read from right to left
      number = self.cc_four_digits.to_s.gsub(/\D/, '').reverse

      sum, i = 0, 0

      number.each_char do |ch|
        n = ch.to_i

        # Step 1
        n *= 2 if i.odd?

        # Step 2
        n = 1 + (n - 10) if n >= 10

        sum += n
        i   += 1
      end

      if (sum % 10).zero?  # Step 3
        return true
      else
        errors.add(:cc_four_digits, 'Sorry, an invalid cardNumber Entered')
        return false
      end

    end

    def set_cc_four_digits
      self.cc_four_digits = cc_four_digits.to_s.last(4).to_i
    end

  #### END CREDIT CARD NUMBER ####
end
