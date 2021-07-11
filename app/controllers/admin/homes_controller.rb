class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
    def top
        @total = 0
        
        if params[:is_customer] == "true"
          # @orders = Order.where(customer_id: params[:customer_id])
          @customer = Customer.find(params[:customer_id])
          @orders = @customer.orders.page(params[:page]).reverse_order
        else
          @orders = Order.page(params[:page]).reverse_order
        end
    end
end
