class ReviewsController < ApplicationController

  def new
    @review = Review.new
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

  # Consider whether deleting a review should be an option
  # def destroy
      # Review.find(params[:id]).destroy
      # redirect_to product_path(@review.product_id)
  # end

  private

  def review_params
    params.require(:review).permit(:rating, :description)
  end

end
