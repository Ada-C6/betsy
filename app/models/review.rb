class Review < ApplicationRecord
  belongs_to :product

  validates :rating, numericality: {greater_than: 0, less_than_or_equal_to: 5}, presence: true
  validates :product_id, presence: true
end
