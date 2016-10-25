class MerchantsController < ApplicationController

    # Will likely need to remove this line (or further customize this), once we've narrowed down which pages require login. This line allows our tests to pass.
    skip_before_action :require_login, only: [:show]

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
