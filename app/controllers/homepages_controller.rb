class HomepagesController < ApplicationController
  before_action :find_all_product, only: [:index, :show_all_products, :show_by_merchant, :show_all_products]

  def index
  	@user= User.find_by(id: session[:user_id])
    @users = User.all
    @categories = Category.all
  end

  def show_by_category
    @cat_products = Category.find(params[:id].to_i).products
    @cat = Category.find(params[:id].to_i)
    if @cat_products.empty?
      redirect_to index_path
    end
  end

  def show_by_merchant
    @merchant_products = @products.where(user_id: params[:id])
    @user_for_products=User.find(params[:id])
    
    if @merchant_products.empty? 
      @most_pop="This merchant has no products yet"
    else
      @most_pop="The most popular product is: #{@merchant_products.sample.name}"
      @products_intro="Here are #{@user_for_products.name}'s products "
    end
    
    if @user_for_products==@user
      @is_my_page=true 
    else
      @is_my_page=false
    end
  end

  private
  def find_all_product
    @products = Product.all
  end
end
