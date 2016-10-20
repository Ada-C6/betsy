class SessionsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    #below is us saying we don't know them (unless they have a uid)
    return redirect to login_failure_path unless auth_hash['uid']

    @user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    #github knows them, but do we?  if not, let's make them an account
    if @user.nil?
      # User doesn't match anything in the DB.
      # Attempt to create a new user.
      @user = User.build_from_github(auth_hash)
      flash[:notice] = "Unable to Save the User"
#using method below to save time
      return redirect_to root_path unless @user.save
      # render :creation_failure unless @user.save
    end

     # Save the user ID in the session
    session[:user_id] = @user.id


    # redirect_to sessions_path
#doing this other thing to save time
    flash[:notice] = "Successfully Logged in!"
    redirect_to root_path

  end

  def edit
  end

  def update
  end

  def destroy
    session[:user_id] = nil 
  end
end
