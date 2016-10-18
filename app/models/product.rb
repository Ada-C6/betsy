class Product < ActiveRecord::Base
  has_many :orderitems
  has_many :reviews
  belongs_to :merchant

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }

end
