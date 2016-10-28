class SessionsController < ApplicationController
  before_action :current_order
  def index
    @user = Merchant.find(session[:user_id]) # < recalls the value set in a previous request
  end

  def create
    auth_hash = request.env['omniauth.auth']
    redirect_to login_failure_path if auth_hash['uid'].nil?

    @user = Merchant.find_by(uid: auth_hash[:uid], provider: 'google')
    if @user.nil?
      # User doesn't match anything in the DB.
      # Attempt to create a new user.
      @user = Merchant.build_from_google(auth_hash)
      unless @user.save
        render :login_failure
        return
      end
    end

    # Save the user ID in the session
    session[:user_id] = @user.id
    redirect_to merchant_path(session[:user_id])
  end

  def destroy
  session.delete(:user_id)
  redirect_to root_path
  end

end
