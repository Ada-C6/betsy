class ProductsController < ApplicationController
  before_action :find_product, except: [:new, :create, :index]
  before_action :require_merchant, only: [:new, :create, :edit, :retire, :update]

  def index
    @merchant = Merchant.find_by(id: session[:user_id].to_i)
  end

  def show
    begin
      @reviews = Review.where(product_id: params[:id])

      @already_in_cart = session[:order] && Order.find(session[:order]).has_product(@product.id)

      @average = average(@reviews)

      if @already_in_cart
        @orderitem = Orderitem.new(quantity: 1) # To display the 1 in the form
        @existing_orderitem = Orderitem.find_by(product: @product)
        @url = orderitems_update_path(@existing_orderitem)
        @method = :patch
      else
        @orderitem = Orderitem.new(quantity: 1)
        @url = orderitems_create_path(params[:id]) # Passing in the product id so we can make a new orderitem
        @method = :post
      end
    rescue ActiveRecord::RecordNotFound
      session[:order] = nil
      flash[:notice] = "Whoops! We had to reset your cart. Please feel free to continue shopping."
      redirect_to products_show_path(params[:id])
    end
  end

  def new
    @action = "Create"
    @product = Product.new

  end

  def edit
    @action = "Edit"
  end

  def create
    @product = Product.create
    @product.name = params[:product][:name]
    @product.price = params[:product][:price]
    @product.merchant_id = session[:user_id].to_i
    @product.description = params[:product][:description]
    @product.photo = params[:product][:photo].to_s
    @product.stock = params[:product][:stock]
    @product.category_ids = params[:product][:category_ids]
    @product.save
    redirect_to products_index_path
  end

  def update

    @product.name = params[:product][:name]
    @product.price = params[:product][:price]
    @product.merchant_id = session[:user_id].to_i
    @product.description = params[:product][:description]
    @product.photo = params[:product][:photo].to_s
    @product.stock = params[:product][:stock]
    @product.category_ids = params[:product][:category_ids]
    @product.save
    redirect_to products_index_path
  end

  def retire
    if @product.retired == true
      @product.retired = false
    else
      @product.retired = true
    end
    @product.save

    redirect_to products_index_path
  end

  def average(reviews)
    average = 0
    reviews.each do |review|
      average += review.rating.to_i
    end
    if average > 0
      average = sprintf('%.2f', (average / @reviews.length.to_f))
    else
      average = "No ratings yet"
    end
    return average
  end

  private
  def find_product
    @product = Product.find(params[:id].to_i)
  end


end
