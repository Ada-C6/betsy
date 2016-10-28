class CategoriesController < ApplicationController
  before_action :find_category, except: [:index, :new, :create]
  before_action :require_login, except: [:index, :show]

  def index
    @categories = Category.all
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to make seller changes" #this only shows if you tell it to show
      redirect_to root_path
    end
  end
end
