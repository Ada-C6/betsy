class SessionsController < ApplicationController

  def index
    if session[:user_id].nil?
      redirect_to login_failure_path
      return
    else
      @merchant = Merchant.find(session[:user_id])
    end
  end

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
    # Save the user ID in the session
    session[:merchant_id] = @merchant.id

    redirect_to sessions_path
  end

  def destroy
    if current_user
      session.delete(:merchant_id)
    end
    redirect_to root_path
  end

end
