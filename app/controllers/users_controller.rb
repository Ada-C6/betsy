class UsersController < ApplicationController
    before_action :set_current_user, only: [:logged_in_index, :new, :edit, :update, :destroy]


  def logged_in_index
   if @user == nil
    flash[:notice] = "please log in to view your accout"
    return redirect_to :back
   end
   @reviews = @user.reviews
  end

  def new
    auth_hash = session[:auth_hash]
    if session[:auth_hash]
      flash[:notice]="You are already registered with github"
      return redirect_to :back
    end

    if session[:auth_hash] == nil
      return redirect_to "/auth/github"
    end
    @user=User.build_from_github(session[:auth_hash])
  end

  def create
    @user=User.new
    flash[:notice] = "unable to save user"
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.uid = params[:user][:uid]
    @user.provider = params[:user][:provider]

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "successfully logged in!"
    end
    return redirect_to index_path
  end

  def edit
  end

  def update
    flash[:notice]= "details failed to save"
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    flash[:notice]= "information updated" if @user.save
  end

  def destroy
  end

  def login
  end

  def logout
  end
  private

  def set_current_user
    @user= User.find_by(id: session[:user_id])
  end
end
