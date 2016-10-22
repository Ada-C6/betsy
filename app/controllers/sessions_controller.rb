class SessionsController < ApplicationController
  def create
    # Build the auth_hash from the Github hash object
    auth_hash = request.env['omniauth.auth']

    # Check to see if we received the auth_hash from Github.
    if auth_hash == nil
      flash[:notice] = "login failed"
      return redirect_to root_path
    end

    @merchant = Merchant.find_by(uid: auth_hash[:uid], provider: 'github')

    if @merchant == nil
      # If merchant doesn't match any record in the DB, attempt to create a new merchant.
      # The method to create the new Merchant (build_from_github) is defined in the
      # Merchant model.
      @merchant = Merchant.build_from_github(auth_hash)

      # Save the Merchant ID in the session (**not the :uid from GitHub**)
      session[:user_id] = @merchant.id
      flash[:notice] = "Successfully logged in"

      return redirect_to merchants_edit_path(@merchant.id)

    end

    session[:user_id] = @merchant.id

    flash[:notice] = "Successfully logged in"
    redirect_to merchants_index_path

  end

  def index
    @merchant = Merchant.find(session[:user_id])
  end

  def destroy
    # Note: the does not log the merchant out of their Github account, which is why
    # when a merchant logs out and then logs back in, they do not have to re-enter
    # their credentials; the application has been authorized to use those credentials
    # and will be able to until the merchant logs out of Github (then they'd have to
    # reenter in their credentials to our app).
    session[:user_id] = nil

    flash[:notice] = "successfully logged out"
    redirect_to root_path
  end
end
