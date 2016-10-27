class Merchant < ActiveRecord::Base
  has_many :products

  def self.build_from_github(auth_hash)
    merchant       = Merchant.new
    merchant.uid   = auth_hash[:uid].to_i
    merchant.provider = 'github'
    merchant.username  = auth_hash['info']['nickname']
    merchant.email = auth_hash['info']['email']
    merchant.save

    return merchant
  end

  validates :username,
            presence: true,
            uniqueness: true

  # validates :displayname,
  #           presence: true,
  #           uniqueness: true

  validates :email,
            presence: true,
            uniqueness: true

  def orders
    products = self.products
    orders = []
    products.each do |product|
      product.orderitems.each do |orderitem|
        if !orders.include?(orderitem.order)
          orders << orderitem.order
        end
      end
    end
    return orders
  end

end
