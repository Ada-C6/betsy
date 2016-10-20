class Category < ActiveRecord::Base
  has_many :product_categories
  has_many :categories, :through => :product_categories
end
