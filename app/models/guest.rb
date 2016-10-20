class Guest < ActiveRecord::Base
  has_many :orders
  has_many :line_items
end
