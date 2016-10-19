class Order < ActiveRecord::Base
  has_many :orderitems
  validates :name, presence: true, uniqueness: { scope: :street_address, :message => "There is already a buyer with this name and address. Please enter a different name and/or address." }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+\z/,
    message: "Email address is not in the correct format" }
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :mailing_zip, presence: true, numericality: { only_integer: true }, format: { with: /\A[0-9]{5}\z/,
    message: "Mailing zip code is invalid, must be 5 digits long" }
  validates :cc_number, presence: true, numericality: { only_integer: true }, format: { with: /\A[0-9]{15,16}\z/,
    message: "Credit card is not valid" }
  validates :cc_exp_month, presence: true
  validates :cc_exp_year, presence: true
  validates :cc_sec_code, presence: true, numericality: { only_integer: true }, format: { with: /\A[0-9]{3,4}\z/,
    message: "Credit card security code is not valid" }
  validates :billing_zip, presence: true, numericality: { only_integer: true }, format: { with: /\A[0-9]{5}\z/,
    message: "Billing zip code is invalid, must be 5 digits long" }
end
