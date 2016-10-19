class User < ActiveRecord::Base
  has_many :transactions
  has_many :reviews
  has_many :products
end
