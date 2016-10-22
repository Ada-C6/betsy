class ProductsController < ApplicationController
  before_action :find_product, except: [:new, :create, :index]

  def index
    @merchant = Merchant.find(params[:id].to_i)

  end

  def show
    @reviews = Review.where(product_id: params[:id])

    @already_in_cart = session[:order] && Order.find(session[:order]).has_product(@product.id)


    if @already_in_cart
      puts "ALREADY IN CART"
      @orderitem = Orderitem.new(quantity: 1) # To display the 1 in the form
      @existing_orderitem = Orderitem.find_by(product: @product)
      puts "GOT HERE"
      @url = orderitems_update_path(@existing_orderitem)
      @method = :patch
    else
      @orderitem = Orderitem.new(quantity: 1)
      @url = orderitems_create_path(params[:id]) # Passing in the product id so we can make a new orderitem
      @method = :post
    end

  end

  def new
  end

  def edit
  end

  def create
  end

  def retire

    if @product.retired == true
      @product.retired = false
    else
      @product.retired = true
    end
  end

  private
  def find_product
    @product = Product.find(params[:id].to_i)
  end

end
