class ReviewsController < ApplicationController
  before_action :merchant_product_self_review, only: [:new]

  def new
    @review = Review.new
    @review.product_id = params[:product_id]
  end

  def create
    @review = Review.new(review_params)
    @product = Product.find(params[:product_id])
    @review.product_id = @product.id
    if @review.save
      redirect_to product_path(@review.product_id)
    else
      render :new
    end
  end

  def merchant_product_self_review
    product = Product.find(params[:product_id])
    if current_user && current_user.id == product.merchant_id
      # flash[:error] = "You cannot review your own product"
      redirect_to product_path(product)
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description, :product_id)
  end

end
