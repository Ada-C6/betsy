class Order < ActiveRecord::Base
  #TODO this line breaks the orders controller destroy test.
  #has_and_belongs_to_many :products

  validates :user_id, presence: true
  validates_associated :user


  belongs_to :user

  # order_products association
  has_many :order_products
  has_many :products, through: :order_products

  belongs_to :billing_address, :class_name => "Address"
  belongs_to :shipping_address, :class_name => "Address"

  def subtotal
    subtotal = 0
    order_products.each do |order_product|
      if order_product.valid?
        subtotal += order_product.qty * order_product.price_per
      end
    end
    return subtotal
  end





end
