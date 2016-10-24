class MerchantsController < ApplicationController

  def show
    begin
      @merchant = Merchant.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end


  private

  def merchant_params
    params.require(:merchant).permit(:user_name, :email, :uid, :provider)
  end
end
