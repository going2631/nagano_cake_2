class Admin::ItemsController < ApplicationController
    def index
        @items = Item.all 
    end
    
    def new
        @item = Item.new
        # @genre = 
    end
    
    def create
        @item = Item.new(item_params)
        if @item.save
            redirect_to admin_item_path(@item.id)
        else
            render "new"
        end
    end
    
    def show
        @item = Item.find(id: params[:id])
    end
    
    def edit
        @item = Item.find(params:id)
    end
    
    def update
        @item = Item.find(id: params[:id])
        
        if @item.update(item_params)
            redirect_to admin_item_path(@item.id)
        else
            render "edit"
        end
    end
    
    private
    def item_params
        params.require(:item).permit(:name,:image, :introduction, :genrn_id, :price, :is_active)
    end
end