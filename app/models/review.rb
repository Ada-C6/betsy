class Review < ActiveRecord::Base
    validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
    validates :description, presence: true, length: { maximum: 400 }
    validates :product_id, presence: true

    belongs_to :product
end


# Reviews:
# Rating: integer default to 1
# Description: string
# Product_ID
# (belongs to a product)
