class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories

  has_many :transaction_products
  has_many :transactions, through: :transaction_products

  has_many :cart_products
  has_many :carts, through: :cart_products

  has_many :reviews

  belongs_to :user
end
