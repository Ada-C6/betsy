class OrdersController < ApplicationController
  def index
    # @products = Product.all
    @orders = Order.all
  end

  def show
    @myorder = Order.find(params[:id])
    if @myorder == nil
      # render :file 'public/404.html', :status => :not_found
    end
  end

  def new
    @myorder = Order.new
    @order_method = :post
    @order_path = orders_path
  end

  def create
    @myorder = Order.new
    # no idea if we need to link via foreignkey or primary
    @myorder.status = params[:order][:status]
    @myorder.first_name = params[:order][:first_name]
    @myorder.last_name = params[:order][:last_name]
    @myorder.email = params[:order][:email]
    @myorder.street_address = params[:order][:street_address]
    @myorder.city = params[:order][:city]
    @myorder.state = params[:order][:state]
    @myorder.zip = params[:order][:zip]
    @myorder.phone = params[:order][:phone]
    @myorder.save
    redirect_to order_path(@myorder.id)
  end

  def edit
    @myorder = Order.find(params[:id])
    # Should I use a patch here?
    @order_method = :put
    @order_path = album_path
    if @myorder == nil
      render :file => 'public/404.html',
      :status => :not_found
    end
  end

  def update
    @myorder = Order.find(params[:id])
    if @myorder == nil
      render :file => 'public/404.html', :status => :not_found
    end
    @myorder.status = params[:order][:status]
    @myorder.first_name = params[:order][:first_name]
    @myorder.last_name = params[:order][:last_name]
    @myorder.email = params[:order][:email]
    @myorder.street_address = params[:order][:street_address]
    @myorder.city = params[:order][:city]
    @myorder.state = params[:order][:state]
    @myorder.zip = params[:order][:zip]
    @myorder.phone = params[:order][:phone]
    @myorder.save
    redirect_to orders_path(@myorder.id)
  end

  def destroy
    @myorder = Order.find(params[:id])
    @myorder.destroy
    redirect_to orders_path(@myorder.id)
  end
end
