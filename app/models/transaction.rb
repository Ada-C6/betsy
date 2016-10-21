class Transaction < ActiveRecord::Base
  has_many :transaction_products
  has_many :products, through: :transaction_products
  belongs_to :user
end
