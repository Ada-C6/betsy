class Order < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  has_many :order_items
end
