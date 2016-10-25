class Review < ActiveRecord::Base
  belongs_to :product

  validates :product, :presence => true
  validates :rating, presence: true, :numericality => {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
end
