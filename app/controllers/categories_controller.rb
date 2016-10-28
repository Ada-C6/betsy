class CategoriesController < ApplicationController
  before_action :find_category, except: [:index, :new, :create]
  before_action :find_user

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category created successfully!"
      redirect_to :action => "index"
    else
      flash[:notice] = "Please be sure you have completed all fields."
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category successfully saved!"
      redirect_to :action => "index"
    else
      flash[:notice] = "Please be sure you have completed all fields."
      render :action => :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to root_path
  end




  private
  def find_category
    @category = Category.find(params[:id])
    if @category.nil?
      render :file => 'public/404.html', :status => :not_found
    end
  end

  def category_params
    params.require(:category).permit(:name,:picture)
  end

  def find_user
    @user = User.find_by(id: session[:user_id])
  end

end
