class Order < ActiveRecord::Base
  has_many :orderitems
  validates :name, presence: true, uniqueness: { scope: :street_address, :message => "There is already a buyer with this name and address. Please enter a different name and/or address." }
  validates :email, presence: true, uniqueness: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true            # Do as drop-down menu (see HH FarMar)
  validates :mailing_zip, presence: true, numericality: { only_integer: true }
  validates :cc_number, presence: true, numericality: { only_integer: true }
  validates :cc_exp_month, presence: true     # Do as drop-down menu
  validates :cc_exp_year, presence: true      # Do as drop-down menu
  validates :cc_sec_code, presence: true, numericality: { only_integer: true }
  validates :billing_zip, presence: true, numericality: { only_integer: true }
end
