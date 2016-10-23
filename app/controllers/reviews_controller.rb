class ReviewsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @product = Product.find(params[:product_id])
    @review.product_id = @product.id
    if @review.save
      redirect_to product_path(@product.id)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description, :product_id)
  end

end
