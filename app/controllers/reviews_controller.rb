class ReviewsController < ApplicationController
  before_action :find_review, only: [:show]

  def index
  	@reviews = Review.all
  end

  def show; end

  def new
    @review = Review.new
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.find(params[:id])
    @review = Review.create(review_params)
    @review.title = params[:review][:title]
    @review.description = params[:review][:description]
    @review.rank = params[:review][:rank]


    @review.product_id = @product.id

    if session[:user_id]
      @review.user_id = session[:user_id]
      @review.name = User.find(session[:user_id]).name
    end

    if @review.save
      redirect_to show_products_path(@product.id)
    else
      render new_review_path
    end
  end

  def edit
  	# NO EDITING
  end

  def update
  	# NO UPDATING
  end

  def destroy
#NO DELETING
  end

  private
    def review_params
      params.require(:review).permit(:rating, :description)
    end

    def find_review
    	@review = Review.find(params[:id])
    end

end
