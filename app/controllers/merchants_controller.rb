class MerchantsController < ApplicationController
  #before_action :find_merchant only: [:show, :edit, :update]

  def index
    find_merchant
  end

  def show
    find_merchant
  end

  def new
    @merchant = Merchant.new
    @path = merchants_path
  end

  def create
  end

  def edit
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
    @merchant = Merchant.find_by(id: session[:merchant_id].to_i)
  end
end
