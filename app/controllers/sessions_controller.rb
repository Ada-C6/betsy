class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    flash[:notice] = "login failed!" 

    return redirect to index_path unless auth_hash['uid']

    @user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    if @user.nil?
      # User doesn't match anything in the DB.
      # Attempt to create a new user.

        session[:auth_hash]=auth_hash
        return redirect_to users_new_path
    end
    # Save the user ID in the session
    session[:user_id] = @user.id
    flash[:notice] = "successfully logged in!"

    redirect_to index_path

  end

  def destroy
    session[:user_id] = nil
    redirect_to index_path
  end

end
