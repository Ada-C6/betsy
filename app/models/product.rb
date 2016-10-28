class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, :through => :line_items

  has_many :product_categories
  has_many :categories, :through => :product_categories

  belongs_to :merchant
  has_many :reviews

  ###############
  ### Methods ###
  ###############

  def rating
    total_rating = 0
    if reviews.length != 0
      reviews.each do |review|
        total_rating += review.stars
      end
      return total_rating/reviews.length
      # Do we want the average to round up or down? Should I add one??
    else
      total_rating = nil
    end
  end


  ###################
  ### Validations ###
  ###################

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :inventory, presence: true
  validates :image, presence: true
  validates :rating, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5, allow_nil: true }

  # validate :limits_on_stars
  #
  # # A rating must be between 0 and 5
  # def limits_on_stars
  #   unless (rating <= 5) && (rating >= 0)
  #     errors.add(:rating, "A rating must be between 0 and 5")
  #   end
  # end
end
