class Admin::HomesController < ApplicationController
    def top
        @total = 0
        if params[:is_customer] == "true"
          @orders = Order.where(customer_id: params[:customer_id])
        else
          @orders = Order.all
        end
    end
end
