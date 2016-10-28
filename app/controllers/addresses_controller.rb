class AddressesController < ApplicationController
  before_action :find_user
  before_action :find_address, except: [:index, :new, :create]


  def index
    @addresses = Address.all

  end

  def show
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.user_id = session[:user_id]
    if @address.save
      if params["redirect_to"] == "1"
        redirect_to account_path
      else
        redirect_to cart_path
      end
    else
      flash[:notice] = "Address could not be saved. Please try again."
      redirect_to new_address_path
    end
  end

  def edit
  end


  def update
    if @address.update!(address_params)
      flash[:notice] = "Address updated."
      redirect_to account_path
    else
      flash[:notice] = "Address could not be updated."
      redirect_to edit_address_path(@address.id)
    end
  end

  def destroy
    @address.destroy!
    flash[:notice] = "Address deleted."
    redirect_to account_path
  end


  private

  def find_user
    @user = User.find_by(id: session[:user_id])
  end

  def find_address
    @address = Address.find(params[:id])
    if @address.nil?
      render :file => 'public/404.html', :status => :not_found
    end
  end

  def address_params
    params.require(:address).permit(:kind, :first_name, :last_name, :street1, :street2, :city, :state, :zip, :country, :phone)
  end

end
