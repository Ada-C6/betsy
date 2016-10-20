class Review < ActiveRecord::Base
  belongs_to :product


  # def star_string
  #   printed_stars = ""
  #   stars.times {|x| printed_stars << "⭐️"}
  #   return printed_stars
  # end
end
