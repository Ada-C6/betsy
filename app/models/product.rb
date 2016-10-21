class Product < ActiveRecord::Base
  has_many :orderitems
  has_many :reviews
  has_many :ordered_products
  has_many :categories, through: :ordered_products
  belongs_to :merchant

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
    where("description LIKE ?", "%#{search}%")
  end
end
