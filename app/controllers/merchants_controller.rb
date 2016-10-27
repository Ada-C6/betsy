class MerchantsController < GuestsController
  before_action :require_login


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
  private

  def current_user
    @current_user ||= Merchant.find_by(id: session[:merchant_id])
  end

  helper_method :current_user ## What is this?

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to login_failure_path
    end
  end
end
