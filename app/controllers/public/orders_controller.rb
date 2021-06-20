class Public::OrdersController < ApplicationController
    
    def new
        @order = Order.new
    end
    
    def confirm
        @order = Order.new(order_params)
        @total = 0
        @shipping_cost =800
        @cart_items = current_customer.cart_items
        
        @order_infomation = params[:order][:address_type]
        if @order_infomation == "0"
            @order.address =current_customer.address 
            @order.postal_code = current_customer.postal_code
            @order.name = current_customer.first_name+current_customer.last_name
        elsif @order_infomation == "1"
            @order = Addless.find(params[:address])
        elsif @order_infomation == "2"
            address = Address.new(postal_code:  @order.postal_code, address: @order.address, name: @order.name)
            address.save
        end
        
        
        
    end
    
    def complete
    end
    
    def create
        @order = Order.new(order_params)
        @order.customer_id = current_customer.id
        @total = 0
        
        if @order.save
            current_customer.cart_items.each do |cart_item| 
               order_detail= OrderDetail.new(item_id: cart_item.item_id,amount: cart_item.amount,price: cart_item.item.price )
               order_detail.order_id = @order.id
               order_detail.save
               cart_item.destroy
            end        
            redirect_to complete_path
        else
            render "new"
        end
    end
    
    def index
        @orders = Order.where(customer_id: current_customer.id)
    end
    
    def show
        @order = Order.find(oarams[:id])
        @order_items = @order.order_detail
        @total = 0
        @shipping_cost =800
    end
    
    private
    
    def order_params
        params.require(:order).permit(:name,:postal_code, :address, :payment_method, :shipping_cost, :total_payment)
    end
end
