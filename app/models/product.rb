class Product < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {
  only_integer: true, greater_than: 0 }


  has_many :reviews
  belongs_to :merchant
  has_and_belongs_to_many :categories
  has_many :order_items
  has_many :orders, through: :order_items

  def product_purchased(qty)
    self.stock -= qty
    self.save
  end
end
