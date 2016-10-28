class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  # must have a subject
  validates :subject, presence: true

  # review must be associated with a user & a product. don't put these in the user & product validations or else we'll get an infinite loop!
  validates :user_id, presence: true
  validates_associated :user

  validates :product_id, presence: true
  validates_associated :product

  # if a review has a rating (not required), that rating must be an integer, and the rating must be between 1 and 5 inclusive.
  # there is probably a better way to write this validation but i just spent 20 minutes on this single line of code, so, moving on.
  validates :rating, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, allow_nil: true}
  # validates_inclusion_of :rating, in: [1, 2, 3, 4, 5, nil], message: "rating must be between 1 and 5"
end
