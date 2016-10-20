class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']

    flash[:notice] = "Login Failed!"
    return redirect to root_path unless auth_hash['uid']

    @merchant = Merchant.find_by(uid: auth_hash[:uid], provider: 'github')
    if @merchant.nil?
      # User doesn't match anything in the DB.
      # Attempt to create a new user.
      @merchant = Merchant.build_from_github(auth_hash)

      flash[:notice] = "Unable to save the User"
      return redirect_to root_path unless @merchant.save
    end


    #Save the user ID in the session
    session[:user_id] = @merchant.id

    flash[:notice] = "Successfully logged in!"
    redirect_to root_path
  end

  # def login
  #   session[:merchant_id] = 1
  #   redirect_to '/products/index'
  # end
  #
  # def logout
  #   session[:merchant_id] = nil
  #   redirect_to '/products/index'
  #  end


  def destroy
    session[:user_id] = nil
  end
end
