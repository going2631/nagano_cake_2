class Public::CustomersController < ApplicationController
    
    def show
      @customer = Customer.find(params[:id])
    end
    
    def edit
      @customer = Customer.find(params[:id])
    end
    
    def update
      @customer = Customer.find(params[:id])
      if @customer.update(customer_params)
        redirect_to customer_path(params[:id])
      else
         render "edit"
      end
    end
    
    def unsubscribe
      @customer = current_customer
    end
    
    def withdraw
      @customer = current_customer
        if @customer.update(is_deleted: params[:customer][:is_deleted])
           reset_session
           redirect_to root_path
        else
           render unsubscribe
        end
    end
    
    
    
    private
    def customer_params
       params.require(:customer).permit(:first_name,:last_name,:first_name_kana,:last_name_kana,:postal_code, :address, :telephone_number, :email, :is_deleted)
    end
end
