class Public::CartItemsController < ApplicationController
    
    def index
        @cart_items = current_customer.cart_items
        @cart_item = CartItem.new
    end
    
    def update
        @cart_item = CartItem.find(params[:id])
        
    
        if @cart_item.update(cart_item_params)
          redirect_to cart_items_path
        else
          @cart_items = current_customer.cart_items
          render "index"
        end
       
    end
    
    def destroy
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
        redirect_to cart_items_path
    end
    
    def destroy_all
        @cart_items = CartItem.where(customer_id: current_customer.id)
        @cart_items.destroy_all
        redirect_to cart_items_path
    end
    
    def create
        @cart_item_currnt = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
        
        if @cart_item_currnt
            
             @cart_item_currnt.update(amount: params[:cart_item][:amount].to_i + @cart_item_currnt.amount)

        else
            @cart_item = CartItem.new(cart_item_params)
            @cart_item.customer_id = current_customer.id
            @cart_item.save
        end
       
        
        
        redirect_to cart_items_path
    end
    
    private
    def cart_item_params
        params.require(:cart_item).permit(:item_id,:amount,:customer_id)
    end
end
