class MerchantsController < GuestsController
  before_action :find_merchant, only: [:edit, :update]

  def index
    @merchant = Merchant.all
  end

  def show
    begin
      @merchant = Merchant.find(params[:id])
    rescue StandardError => err
      render "/errors/not_found", status: :not_found
    end
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

  def edit; end

  def update
    if @merchant.update(merchant_params)
      redirect_to merchant_path
    else
      render :edit
    end
  end

  def destroy
    @merchant = Merchant.find(params[:id]).destroy
    redirect_to merchan_path
  end

  private

  def merchant_params
    params.require(:merchant).permit(:username, :email)
  end

  def find_merchant
    @merchant = Merchant.find(params[:id])
  end
end
