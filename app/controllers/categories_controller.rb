class CategoriesController < ApplicationController
  before_action :require_login, only: [:create, :new]

  def new
    @category = Category.new
  end

  def show
    @category = Category.find(params[:category_id])
    @products = @category.products.where(active: true)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to(:back)
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to login_failure_path
    end
  end

end
