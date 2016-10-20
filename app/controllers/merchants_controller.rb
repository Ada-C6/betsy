class MerchantsController < ApplicationController
  #before_action :find_merchant only: [:show, :edit, :update]

  def index
    @merchants = Merchant.all
  end

  def show
    find_merchant
  end

  def new
    @merchant = Merchant.new
    @path = merchants_path
  end

  def create
    @params = params
    @merchant = Merchant.new
    @merchant.name = params[:merchant][:name]
    @merchant.email = params[:merchant][:email]
    @merchant.password = params[:merchant][:password]
    if @merchant.save
      redirect_to merchant_path(@merchant.id)
    else
      render :new
    end

  end

  def edit
    find_merchant
  end

  def update
  end

  def destroy
  end

  def show_merchant_products
    find_merchant
    @products = Product.find_by(merchant_id: @merchant.id)
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name, :email, :password)
  end

  def find_merchant
    @merchant = Merchant.find(params[:id])
  end
end
