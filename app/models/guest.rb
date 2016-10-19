class Guest < ActiveRecord::Base
  has_many :orders
end
