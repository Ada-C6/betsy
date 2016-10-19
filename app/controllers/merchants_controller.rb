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
    @path = merchants_create_path
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      redirect_to merchants_path
    else
      render :new
    end

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name, :email, :password)
  end

  def find_merchant
    @merchant = Merchant.find(params[:id])
  end
end
