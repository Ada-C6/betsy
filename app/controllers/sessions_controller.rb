class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:index_log_out, :login, :create]

  def index_log_out
    render 'sessions/index'
  end

  def index_log_in
    render 'sessions/index'
  end

  def create
    auth_hash = request.env['omniauth.auth']
    redirect_to login_failure_path unless auth_hash['uid']
    @merchant = Merchant.find_by(uid: auth_hash[:uid], provider: 'github')
    if @merchant.nil?
      @merchant = Merchant.build_from_github(auth_hash)
      render :creation_failure unless @merchant.save
    end

    # Save the user ID in the session
    session[:merchant_id] = @merchant.id
    redirect_to sessions_log_in_path
  end

  def login_failure; end

  def login; end

  def destroy
    session.delete(:merchant_id)
    redirect_to sessions_log_out_path
  end

  def merchant_login
    # @merchant = Merchant.find(session[:merchant_id])
  end
end
