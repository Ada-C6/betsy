class Order < ActiveRecord::Base
  has_many :orderitems
end
