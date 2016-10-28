class SessionsController < ApplicationController

    def create
      auth_hash = request.env['omniauth.auth']
      redirect_to login_failure_path unless auth_hash['uid']

      @user = User.find_by(uid: auth_hash[:uid], provider: 'github')

      if @user.nil?
        # User doesn't match anything in the DB.
        # create a new user.
        @user = User.build_from_github(auth_hash)
        render :creation_failure unless @user.save
      end

      @order = Order.find_by(user_id: @user.id, order_status: 'cart')
      if @order.nil?
        @order = Order.create(user_id: @user.id, order_status: 'cart')
      end

      # Save the user ID in the session
      session[:user_id] = @user.id
      session[:cart_id] = @order.id

      redirect_to root_path
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_path
    end

    # registration first takes the auth stuff and then
end
