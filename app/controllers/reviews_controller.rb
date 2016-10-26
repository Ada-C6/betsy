class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new
    @review.rating = params[:review][:rating]
    @review.feedback = params[:review][:feedback]
    @review.product_id = params[:id]
    @review.save

    redirect_to products_show_path(@review.product_id)
  end
end
