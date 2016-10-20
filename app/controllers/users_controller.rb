class UsersController < ApplicationController
  
  # before_action :find_user only [:show, :edit, :update, :destroy]

#AN IDEA FOR HOW TO LIMIT PRODUCT EDITING?
   # app/controllers/users_controller
    # before_action :require_login
    # ...
    # private
    # def require_login
    #   # do stuff to check if user is logged in
    # end


  def index
    return User.all
  end

  def show
    @my_user = User.find{ params[:id].to_i } 
  end

  def new
    @my_user = User.new
    @path = 'new_path'
  end

  def create
  end

  def edit
    @my_user = User.find{ params[:id].to_i } 
    @path = 'update_path'
  end

  def update
    @my_user = User.find{ params[:id].to_i }
    @params = params
    @my_user.first_name = params[:user][:first_name]
    @my_user.last_name = params[:user][:last_name] 
    @my_user.email = params[:user][:email]
    @my_user.street_address = params[:user][:street_address]
    @my_user.city = params[:user][:city]
    @my_user.state = params[:user][:state]
    @my_user.zip = params[:user][:zip]
    @my_user.phone = params[:user][:phone]
    @my_user.merchant = params[:user][:merchant]
    @my_user.provider = params[:user][:provider]
    @my_user.status = params[:user][:status]
  end

#really is 'deactivate'
  def destroy
    @my_user = User.find{ params[:id] }
    @my_user.status = false
    @my_user.save
  end
end

private

  def find_user
    @my_user = User.find{ params[:id] }
  end