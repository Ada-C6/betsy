class ProductsController < ApplicationController
  def index
    @products = Product.all.order("name")
  end

  def show
    @product = Product.find_by_id(params[:id].to_i)

    if @product.user_id
      @seller = @product.user
      # @seller = User.find(@product.user_id)
    else
      @seller = User.new
    end

    @reviews = Review.where(:product_id => @product.id)

  end

  def show_seller_products
    @product = Product.find(params[:id].to_i)
    @products = Product.where(:user_id => @product.user_id)
  end

  def search
     @products = Product.search(params[:query])
     # if product query matches a product(s)
     # render those image(s), if any match.
     render :index
  end


  def new
    @product = Product.new
    @post_method = :post
    @post_path = 'create'
  end

  def create

    @product = Product.new(name: params[:product][:name], description: params[:product][:description], price: params[:product][:price], inventory: params[:product][:inventory], category: params[:product][:category], user_id: session[:user_id])
    @product.save

    redirect_to show_seller_products_path(@product.id)
    # does rails think I mean to redirect to the method instead of the path? why doesn't it need an id for this route?
  end

  def edit
  	@product = Product.find(params[:id])
  	@post_method = :patch
  	@post_path = 'update'

  end

  def update
  	# @params = params

  	@post_method = :patch
  	@post_path = 'update'



  	@product = Product.find(params[:id])

  	if @product == nil
  		render :file => 'public/404.html'
  			# :status => :not_found
  	end

  	@product.name = params[:product][:name]
  	@product.description = params[:product][:description]
  	@product.inventory = params[:product][:inventory]
  	@product.category = params[:product][:category]
  	if @product.save
  		redirect_to show_products_path(@product.id)
  	# else
  	# 	@error = "Did not save successfully.  Try again!"
  	end




  end

  def destroy
  	@product = Product.find(params[:id])
  	@product.destroy

    redirect_to root_path
  end




end
