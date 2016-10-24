class SessionsController < ApplicationController
  # def index
  # end

  # def show
  # end

  def new

  end

  def create

    #AUTHENTICATION FROM SCRATCH START
    # user = User.find_by email: params[:login][:email]

    # if user && user.authenticate(params[:login][:password])
    #   session[:user_id] = user.id
    #   redirect_to root_path, notice: 'Successfully logged in.'
    # else
    #   flash.now.alert = 'Invalid email or password.'
    #   render :new
    # end
  #AUTHENTICATION FROM SCRATCH END


    #GITHUB AUTHENTICATION START
    auth_hash = request.env['omniauth.auth']
    
    return redirect_to root_path unless auth_hash['uid']

    @user = User.find_by(uid: auth_hash[:uid], provider: 'github')

    if @user.nil?
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

#GITHUB AUTHENTICATION END
  end

  # def edit
  # end

  # def update
  # end

  def destroy
    session[:user_id] = nil 
    redirect_to root_path, notice: 'Successfully logged out.'
  end
end
