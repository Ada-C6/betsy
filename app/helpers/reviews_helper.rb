module ReviewsHelper
  def show_lemons(review)
    image_tag "#{review.rating}lemon.jpg"
  end
end
