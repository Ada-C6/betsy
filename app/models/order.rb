class Order < ActiveRecord::Base
  has_many :orderitems
  validates :name, presence: true, uniqueness: { scope: :street_address, :message => "There is already a buyer with this name and address. Please enter a different name and/or address." }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+\z/,
    message: "Email address is not in the correct format" }
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :mailing_zip, presence: true, numericality: { only_integer: true }
  validates :cc_number, presence: true, numericality: { only_integer: true }
  validates :cc_exp_month, presence: true
  validates :cc_exp_year, presence: true
  validates :cc_sec_code, presence: true, numericality: { only_integer: true }
  validates :billing_zip, presence: true, numericality: { only_integer: true }
end
