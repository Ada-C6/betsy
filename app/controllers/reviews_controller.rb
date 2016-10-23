class ReviewsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description, :product_id)
  end

end
