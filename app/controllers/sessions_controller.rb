class SessionsController < ApplicationController
# If we want to implement this later, will need to customize authorization specifics...
    # skip_before_action :require_login, only: [:login, :create]

    def login_failure; end

    def login; end

    def create
        auth_hash = request.env['omniauth.auth']
        redirect_to login_failure_path unless auth_hash['uid']

        @merchant = Merchant.find_by(uid: auth_hash[:uid], provider: 'github')
        if @merchant.nil?
            # Merchant doesn't match anything in the DB.
            # Attempt to create a new merchant.
            @merchant = Merchant.build_from_github(auth_hash)
            render :login_failure unless @merchant.save
        end

        # Save the merchant ID in the session
        session[:merchant_id] = @merchant.id

        redirect_to sessions_path
    end

    def index
        if session[:merchant_id].nil?
            redirect_to login_failure_path
        else
            @merchant = Merchant.find(session[:merchant_id]) # < recalls the value set in a previous request
        end
    end

    def destroy
        session.delete(:merchant_id)
        redirect_to login_failure_path
    end

end
