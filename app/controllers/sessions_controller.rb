class SessionsController < ApplicationController
skip_before_action :require_login, only: [:create, :login_failure]

  def create
    auth_hash = request.env['omniauth.auth']
    redirect_to login_failure_path if auth_hash['uid'].nil?

    @merchant = Merchant.find_by(uid: auth_hash[:uid], provider: 'github') # Remember: .find_by always returns one object (the first that matches)
    if @merchant.nil?
      # merchant doesn't match anything in the DB.
      # Attempt to create a new merchant
      @merchant = Merchant.build_from_github(auth_hash)
      render :creation_failure unless @merchant.save # This line saves the newly built @merchant to the database if it can be saved
    end
    # Save the merchant ID in the session
    session[:merchant_id] = @merchant.id
    redirect_to root_path
  end

  def login_failure; end

  def destroy
    if current_user
      session.delete(:merchant_id)
    end
    redirect_to root_path
  end

end
