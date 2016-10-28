class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']

    return redirect to root_path unless auth_hash['uid']

    @merchant = Merchant.find_by(uid: auth_hash[:uid])
    if @merchant.nil?
      @merchant = Merchant.build_from_github(auth_hash)
      flash[:notice] = "Unable to save the Merchant"
      return redirect_to root_path unless @merchant.save
    end

    #Save the merchant ID in the session
    session[:merchant_id] = @merchant.id.to_i
    # binding.pry
    redirect_to merchant_path(@merchant.id)
  end

  def create_merchant
  end

  # def login
  #   session[:merchant_id] = 1
  #   redirect_to '/products/index'
  # end
  #
  # def logout
  #   session[:merchant_id] = nil
  #   redirect_to root_path
  #  end


  def destroy
    session[:merchant_id] = nil
    redirect_to root_path
  end
end
