class ProductsController < ApplicationController
  before_action :find_user
  before_action :find_product, except: [:index, :new, :create]


  def index
    @products = Product.all.where(active: true)

    if params[:search]
      @products = Product.search(params[:search]).order("name DESC")
    else
      @products = Product.all.order('name DESC')
    end
  end
  # why is review in products controller, do we have a review controller?
  def show
    @review = Review.new
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.category_id = params[:category_id]
    if @product.save
      flash[:notice] = "Product created successfully!"
      redirect_to action: "index"
    else
      flash[:notice] = "Please be sure you have completed all fields."
      render :action => :new
    end
  end

  def edit
    # @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  def update
    @product.category_id = params[:category_id]
    if @product.update(product_params)
      flash[:notice] = "Product successfully saved!"
      redirect_to action: "show"
    else
      flash[:notice] = "Please be sure you have completed all fields."
      render :action => :edit
    end
  end
  #
  # def destroy
  #   @product.destroy
  #   redirect_to root_path
  # end

  def switch_active
    product = Product.find_by(id: params[:id])
    product.toggle_active
    product.save
    redirect_to product_path
  end

  private
  def find_user
    @user = User.find_by(id: session[:user_id])
    if !@user.nil?
      @order = Order.find_by(user_id: @user.id, order_status: 'cart')
      if @order.nil?
        @order = Order.create(user_id: @user.id, order_status: 'cart')
      end
    else
      # This should really be sessions
      @order = Order.create(order_status: 'cart')
    end
  end

  def find_product
    @product = Product.find(params[:id])
    if @product.nil?
      render :file => 'public/404.html', :status => :not_found
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :inventory_qty, :category_id, :picture)
  end



end
