class ReviewsController < ApplicationController
  before_action :find_review, except: [:index, :new, :create]

  def index
    @reviews = Review.all
  end

  def show
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.rating = params[:rating]
    @review.user_id = session[:user_id]
    @review.product_id = params[:product_id]
    if @review.save!
      redirect_to product_path(@review.product_id)
    else
      flash[:notice] = "Please be sure you have completed all fields."
      render :action => :new
    end
  end

  def edit
  end

  def update
    @review.rating = params[:rating]
    if @review.update(review_params)
      flash[:notice] = "Review successfully saved!"
      redirect_to product_path(@review.product_id)
    else
      flash[:notice] = "Please be sure you have completed all fields."
      render :action => :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to root_path
  end




  private
  def find_review
    @review = Review.find(params[:id])
    if @review.nil?
      render :file => 'public/404.html', :status => :not_found
    end
  end

  def review_params
    params.require(:review).permit(:subject, :body, :rating)
  end

end
