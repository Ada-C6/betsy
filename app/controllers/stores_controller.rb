class StoresController < ApplicationController
  def index
    @stores = Merchant.all
  end

  def show
    @store = Merchant.find(params[:id])
  end
end
