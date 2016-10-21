class OrderItemsController < ApplicationController
    def create
        @order = current_order
        @order_item = @order.order_items.new(order_item_params)
        @order.save
        session[:order_id] = @order.id
        redirect_to products_path
    end

    def update
        @order = current_order
        @order_item = @order.order_items.find(params[:id])
        if @order_item.update(order_item_params)
            @order_item.save
            redirect_to order_path(params[:order_id])
        else
            render :edit
        end
    end

    def edit
        @order = current_order
        @order_item = @order.order_items.find(params[:id])
    end

    def destroy
        @order = current_order
        @order_item = @order.order_items.find(params[:id]).destroy
        redirect_to order_path(params[:order_id])  
    end


    private
    def order_item_params
        params.require(:order_item).permit(:quantity, :product_id, :order_id, :shipped?)
    end
end
