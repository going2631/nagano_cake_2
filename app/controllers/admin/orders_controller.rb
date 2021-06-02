class Admin::OrdersController < ApplicationController
    
    def show
        @order = Order.find(params[:id])
        @order_details = @order.order_details
    end
    
    def uodate
        @order = Order.find(params[:id])
        if @order.update(order_params)
            redirect_to admin_order_path(oarams[:id])
        end
    end
    
    private
    
    def order_params
        params.require(:order).permit(:status)
    end
end
