class Product < ActiveRecord::Base
  belongs_to :merchant
  has_many :orderitems
  has_many :reviews
  has_and_belongs_to_many :categories

  validates :name,
            presence: true,
            uniqueness: true

  validates :price,
            presence: true,
            numericality: { greater_than: 0 }

  validates :merchant,
            presence: true

end
