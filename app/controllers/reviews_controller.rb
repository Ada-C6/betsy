class ReviewsController < ApplicationController
  before_action :check_if_selling_merchant

  def new
    @review = Review.new
  end

  def create
    @review = Review.new
    @review.rating = params[:review][:rating]
    @review.feedback = params[:review][:feedback]
    @review.product_id = params[:id]

    if @review.save
      redirect_to products_show_path(@review.product_id)
    else
      render :new, :status => :error
    end
  end

  private

  def check_if_selling_merchant
    if session[:user_id] && session[:user_id].to_i == Product.find_by(id: params[:id]).merchant.id
      flash[:notice] = "Sorry, you cannot leave a review on your own product."
      redirect_to products_show_path(params[:id])
    end
  end

end
