class MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show, :edit, :update]

  def show; end


  private

  def find_merchant
    begin
      @merchant = Merchant.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end

  def merchant_params
    params.require(:merchant).permit(:user_name, :email, :uid, :provider)
  end
end
