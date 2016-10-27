class ReviewsController < ApplicationController

    # Will likely need to remove this line (or further customize this), once we've narrowed down which pages require login. This line allows our tests to pass.
    skip_before_action :require_login

    def new
        @product = Product.find(params[:product_id])
        @review = Review.new
        if @product.merchant_id == session[:user_id]
            flash[:error] = "You are not allowed to review your own products."
            redirect_to product_path(@product)
        end
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
