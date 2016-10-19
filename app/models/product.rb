class Product < ActiveRecord::Base
  belongs_to :merchant
  has_many :orderitems
  has_many :reviews
  has_and_belongs_to_many :categories
end
