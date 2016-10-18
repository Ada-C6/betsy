class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:login, :create]

  def index
    if session[:user_id].nil?
      redirect_to login_failure_path
      return
    end
      @user = User.find(session[:user_id]) # < recalls the value set in a previous request
  end

  def create
    # 'omniauth.auth' is the has provided by OmniAuth
    # request sort of corresponds with HTTP request, but there's a lot more stuff
    # .env does not mean environment variable, it's just the way it is
    auth_hash = request.env['omniauth.auth']
    redirect_to login_failure_path unless auth_hash['uid']

    @user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    if @user.nil?
      # User doesn't match anything in the DB.
      # Attempt to create a new user.
      @user = User.build_from_github(auth_hash)
      render :creation_failure unless @user.save # Saves user if able to
    end

    # Save the user ID in the session
    session[:user_id] = @user.id

    redirect_to sessions_path
  end

  def login; end

  def login_failure; end

  def destroy
    session.delete(:user_id)
    redirect_to login_failure_path
  end
end
