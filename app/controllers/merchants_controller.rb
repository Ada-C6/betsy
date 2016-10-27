class MerchantsController < GuestsController
before_action :require_login, only: [:create]

  # def index
  #   @merchant = Merchant.all
  # end

  # def new
  #   @merchant = Merchant.new
  # end
  #
  def create
    @merchant = Merchant.new(merchant_params)
    # Need to intialize number of merchants to 1 upon creation
    if @merchant.save
      redirect_to merchant_path(@merchant)
    else
      render :new
    end
  end

  def show
    @merchant = Merchant.find(params[:id])
    @products = Product.where(merchant_id: @merchant.id).where(active: true)

    @inactive_products = Product.where(merchant_id: @merchant.id).where(active: false) if current_user
  end

  def products
    @merchants = Merchant.all
    @merchant = Merchant.find(params[:merchant_id])
    @products = Product.where(merchant_id: @merchant.id).where(active: true)

    @inactive_products = Product.where(merchant_id: @merchant.id).where(active: false) if current_user
  end

  private

  def merchant_params
    params.require(:merchant).permit(:username, :email)
  end

end
