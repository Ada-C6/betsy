class Address < ActiveRecord::Base
  belongs_to :user

  # address must have a kind, last name, 1st line of street address, city, state, and country

  validates_presence_of :kind, :last_name, :street1, :city, :state, :country

  # address must be associated with a user. don't put this in the user validations or else we'll get an infinite loop!
  validates :user_id, presence: true
  validates_associated :user
end
