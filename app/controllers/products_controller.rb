class ProductsController < ApplicationController

    before_action :require_login, except: [:index, :show, :category, :seller, :popular]

    def index
      # NOTE: This action is currently unused
      @products = Product.all
    end

    def new
      @product = Product.new
      @categories = Category.all.map do | category |
        [category.name, category.id]
      end
    end

    def show
      @product = Product.find(params[:id])
      @order = Order.find(session[:cart_id])
      @order_item = @order.order_items.new(quantity: 1)
      @reviews = @product.reviews
    end

    def create
      @product = @user.products.new(product_params) #EN: I think this will need to change to .new with params or @user.products.new to associate user_id with the product]
        unless params[:product][:categories_products].nil?
          cat_ids = params[:product][:categories_products]
        end
        unless params[:product][:categories].nil?
          new_cat = params[:product][:categories][:name].capitalize ##commented out for product-tests
        end
      if @product.save

        new_category(cat_ids, new_cat)
        #  new_category(cat_ids, new_cat) ##product-test comment
        #  raise
        redirect_to user_path(@user)
      else
        render :new
      end
    end

    def destroy
      @product = Product.find(params[:id])
      if @product.user_id != @user.id
        flash[:error] = "You cannot delete another seller's products! STOP BEING SHADY, YO"
        redirect_to root_path # might need to add a return here if doesn't work as expected
      else
        @product.destroy # make sure this doesn't execute if the condition is met above
      end
      redirect_to products_path
    end

    def edit
       @product = Product.find(params[:id])
       if @product.user_id != @user.id
         flash[:error] = "You cannot edit another seller's products! WHY ARE YOU TRYING? SHADY, YO"
         redirect_to root_path # might need to add a return here if doesn't work as expected
       end
       @categories = Category.all.map do | category |
         [category.name, category.id]
       end
    end

    def update # EN: do I need the same logic from edit?
      @product = Product.find(params[:id])
      @product.update(product_params)
      # raise
      unless params[:product][:categories_products].nil?
        cat_ids = params[:product][:categories_products]
      end
      unless params[:product][:categories].nil?
        new_cat = params[:product][:categories][:name].capitalize ##commented out for product-tests
      end
      if @product.save
        new_category(cat_ids, new_cat)
        redirect_to product_path(@product.id)
      else
        render :edit
      end
    end

    def category
      @product =Product.where(name: :q)
    end

    def seller
      @products = Product.find(params[:user_id])
    end

    def popular
      @products = Product.products_by_rating

      render :index
    end

    def retire
      @product = Product.find(params[:id])
      @productstatus = params[:productstatus]
      if @product.user_id != @user.id
        flash[:error] = "You cannot delete another seller's products! STOP BEING SHADY, YO"
        redirect_to root_path
      end
      if @productstatus == "retire"
        @product.retire
      end
      if @productstatus == "activate"
        @product.activate
      end
      if @product.save
        redirect_to user_path(@user.id)
      end
    end

    private

    def product_params
      params.require(:product).permit(:id, :user_id, :name, :price, :inventory, :description, :photo_url, :retired, :created_at, :updated_at )
    end

    def current_user
      @user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def require_login
      if current_user.nil?
        flash[:error] = "You must be logged in to make seller changes" #this only shows if you tell it to show
        redirect_to root_path
      end
    end

    def new_category(cat_ids, new_cat)
      unless cat_ids.nil?
        cat_ids.each_value do |v|
          unless v.blank?
            @product.categories << Category.find(v)
          end
        end
        unless new_cat.blank? || new_cat.nil?
          new_category = @product.categories.new(name: new_cat)
          if new_category.valid?
            new_category.save
            @product.categories << new_category
          else
            @product.categories << Category.find_by(name: new_cat)
          end
        end
      end
    end
end
