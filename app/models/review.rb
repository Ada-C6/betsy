class Review < ActiveRecord::Base
  belongs_to :product




  ###################
  ### Validations ###
  ###################

  validates :stars, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5, allow_nil: true }
  validates :description, presence: true

end
