class User < ActiveRecord::Base
  has_many :review_id
  has_many :product_id
  has_many :user_id
end
