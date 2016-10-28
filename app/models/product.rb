class Product < ApplicationRecord
  dragonfly_accessor :image
  # validates_property :mime_type, of: :image, in: %w(image)
  has_many :order_items
  has_many :reviews

  belongs_to :merchant

  has_many :categories, through: :categories_products
  has_many :categories_products
  accepts_nested_attributes_for :categories, reject_if: :all_blank

  validates :name, presence: :true, uniqueness: :true
  validates :price, presence: :true, numericality: {greater_than: 0}
  validates :merchant_id, presence: :true

  # when purchasing, pass a negative number
  def update_quantity(number)
    number = number.to_i
    if number > 0 || check_availability(-number)
       self.quantity += number
       # save this to the database
       self.save
       return self.quantity
    end
  end

  def check_availability(number)
    self.quantity >= number
  end

  def retire_product
    self.active = false
  end

  def unretire_product
    self.active = true
  end

end
