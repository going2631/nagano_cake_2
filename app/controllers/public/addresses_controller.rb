class Public::AddressesController < ApplicationController
    
    before_action :authenticate_customer!
    # before_action :correct_address
    
    
    def index
        @address = Address.new
        @addresses = Address.where(customer_id: current_customer.id )
    end
    
    def edit
        @address = Address.find(params[:id])
    end
    
    def create
        @addresses = Address.where(customer_id: current_customer.id )
        @address = Address.new(address_params)
        if @address.save
            redirect_to addresses_path
        else
            render "index"
        end
    end
    
    def update
        @address = Address.find(params[:id])
        if @address.update(address_params)
            redirect_to addresses_path
        else
            render "edit"
        end
    end
    
    def destroy
        @address = Address.find(params.id)
        @address.destroy
        redirect_to address_path
    end
    
    # def correct_adress
    #       @address = Address.find(params[:id])
    #   unless @address.customer.id == current_customer.id
    #     redirect_to new_customer_session_path
    #   end
    # end
    
    private
    
    def address_params
        params.require(:address).permit(:postal_code,:address, :name, :customer_id)
    end
end
