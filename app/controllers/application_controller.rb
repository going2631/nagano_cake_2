class ApplicationController < ActionController::Base
    
      before_action :configure_permitted_parameters, if: :devise_controller?
      
      
      helper_method :current_user

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address,:telephone_number])
  end
  
  
  def after_sign_out_path_for(resource)
    if resource == :customer
      root_path 
    else 
      new_admin_session_path
    end
  end
  
  def current_cart
    if session[:cart_id]
      @cart_ite = CartItem.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end
end
