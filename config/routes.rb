Rails.application.routes.draw do
  
  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  devise_for :admins
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :admin do
    root to: "homes#top"
    resources :items
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :edit, :update, :show]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
  
  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    
    resources :items, only: [:index, :show]
    
    delete "destroy_all" => "cart_items#destroy_all"
    resources :cart_items, only: [:index, :update, :destroy, :create]
    
    post  "confirm" => "orders#confirm"
    get "complete" =>"orders#complete"
    resources :orders , only: [:new, :create, :index, :show ]
    
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    
    get "unsubscribe" => "customers#unsubscribe"
    patch "withdraw" => "customers#withdraw"
    
    resources :customers, only: [:show, :edit, :update]
  end
end
