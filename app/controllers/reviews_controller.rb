class ReviewsController < ApplicationController

  def index; end

  def new
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new

    if !session[:user_id].nil? && session[:user_id] == @product.user.id
      flash[:errors] = "Sorry, vendors cannot review their own products."
      redirect_to product_path(@product)
    end
  end

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)

    if @review.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:product_id, :review, :rating)
  end
end
