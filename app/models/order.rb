class Order < ActiveRecord::Base
  has_many :order_items
  before_validation :initial_order_status, only: [:create]

    validates :name, presence: true, uniqueness: { scope: :street_address, :message => "There is already a buyer with this name and address. Please enter a different name and/or address." }, unless: :pending?
    validates :email, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+\z/,
      message: "Email address is not in the correct format" }, unless: :pending?
    validates :street_address, presence: true, unless: :pending?
    validates :city, presence: true, unless: :pending?
    validates :state, presence: true, unless: :pending?
    validates :mailing_zip, presence: true, numericality: { only_integer: true }, format: { with: /\A[0-9]{5}\z/,
      message: "Mailing zip code is invalid, must be 5 digits long" }, unless: :pending?
    validates :cc_number, presence: true, numericality: { only_integer: true }, format: { with: /\A[0-9]{15,16}\z/,
      message: "Credit card is not valid" }, unless: :pending?
    validates :cc_exp_month, presence: true, unless: :pending?
    validates :cc_exp_year, presence: true, unless: :pending?
    validates :cc_sec_code, presence: true, numericality: { only_integer: true }, format: { with: /\A[0-9]{3,4}\z/,
      message: "Credit card security code is not valid" }, unless: :pending?
    validates :billing_zip, presence: true, numericality: { only_integer: true }, format: { with: /\A[0-9]{5}\z/,
      message: "Billing zip code is invalid, must be 5 digits long" }, unless: :pending?

    # validate :card_not_expired, unless: :pending? # will come back to this


  private

  # def card_not_expired
  #   return if cc_exp_month.nil? || cc_exp_year.nil?
  #   if (cc_exp_month < Time.now.month) && (cc_exp_year <= Time.now.year) ||
  #     errors.add(:cc_exp_year, "Bummer. Your card is expired. Please use a different card.")
  #   end
  # end

  def initial_order_status
    if order_status == nil
      self.order_status = "pending"
    end
  end

  def pending?
    self.order_status == "pending"
  end

end
