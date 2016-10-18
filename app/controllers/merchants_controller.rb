class MerchantsController < GuestsController

  def index
    @merchant = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
    @products = Product.where(merchant_id: @merchant.id)
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    # Need to intialize number of merchan to 1 upon creation
    if @merchant.save
      redirect_to merchant_path(@merchant)
    else
      render :new
    end
  end

  private

  def merchant_params
    params.require(:merchant).permit(:username, :email)
  end

end
