class ReviewsController < ApplicationController
  before_action :merchant_product_self_review, only: [:new]


  def new
    @review = Review.new
    @review.product_id = params[:product_id]
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to product_path(@review.product_id)
    else
      render :new
    end
  end

  def edit; end # Consider: Is an edit/update review option even necessary?

  def update
    if @review.update(@review_params)
      redirect_to product_path(@review.product_id)
    else
      render :edit
    end
  end

  # Consider whether deleting a review should be an option
  # def destroy
      # Review.find(params[:id]).destroy
      # redirect_to product_path(@review.product_id)
  # end

  def merchant_product_self_review
    if current_user && current_user.id == Product.find(params[:product_id]).merchant_id
      # flash[:error] = "You cannot review your own product"
      redirect_to product_path(Product.find(params[:product_id]))
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description, :product_id)
  end

end
