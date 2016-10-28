class CategoriesController < ApplicationController
  before_action :get_category, only: [:show]
  
  #only logged in Merchant user can create a new Category
  skip_before_action :require_login, except: [:new, :create]

  # categories GET    /categories
  def index
    @categories = Category.all
  end

  # new_category GET    /categories/new
  def show
    @products = @category.products.where(active: true)
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # categories POST   /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # I don't think we should be able to edit catergories, only add so I don't think we need this
    def category_params
      params.require(:category).permit(:name)
    end
end
