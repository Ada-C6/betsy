class Product < ActiveRecord::Base
  has_many :orderitems
  has_many :reviews
  belongs_to :merchant
end
