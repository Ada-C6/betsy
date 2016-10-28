class HomeController < ApplicationController
  skip_before_action :require_login, only: [:index]
  def index
    reviews = Review.all.where(rating: 5)
    @popular = []
    reviews.each do |review|
      @popular << Product.find(review.product_id)
    end
    return @popular.uniq!
  end
end
