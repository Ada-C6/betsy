class MerchantsController < ApplicationController

    def index
        @merchants = Merchant.all.order(:user_name)
    end

    def show
        begin
            @merchant = Merchant.find(params[:id])
            @products = @merchant.products.where(active: true)
        rescue ActiveRecord::RecordNotFound
            render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
        end
    end

    private

    def merchant_params
        params.require(:merchant).permit(:user_name, :email, :uid, :provider)
    end
end
