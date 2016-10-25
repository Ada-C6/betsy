class Product < ActiveRecord::Base
  has_many :reviews
  belongs_to :merchant

  has_many :order_items
  has_many :orders, :through => :order_items

  has_many :product_categories

  # The way to do a nested form (this might just not be working because there's no create product_categories action)
  accepts_nested_attributes_for :product_categories

  has_many :categories, :through => :product_categories

  validates :name, presence: true, uniqueness: true

  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }

  # Having product require at least one category before being saved to the database is making it impossible to create new products (chicken/egg problem), so I'm commenting it out for now. 
  #
  # validates :categories, :length => { :minimum => 1 }

  validates :merchant, :presence => true

  # Same here - I think this is important to have validated (cannot have negative stock.)
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
