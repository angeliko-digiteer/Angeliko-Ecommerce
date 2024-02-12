Rails.application.routes.draw do
  
  # Devise routes for admin and users
  
  devise_for :admin, controllers: { sessions: 'admin/sessions', registrations: 'admin/registrations' }
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  # Root route
  root 'pages#home'

  # Admin namespace for products
  namespace :admin do
    resources :products
    resources :user_checkouts, only: [:index, :show]
  end


  # Users namespace for products, cart, and checkout
  namespace :users do
    resources :products, only: [:index, :show]
    
    # Cart routes
    resource :cart, only: [:show, :update, :destroy] do
      post 'add_item/:product_id', to: 'carts#add_item', as: 'add_item'
      delete 'remove_item/:id', to: 'carts#remove_item', as: 'remove_item_from_cart' # Renamed to ensure uniqueness
      post 'checkout', to: 'carts#checkout', as: 'checkout'
    end
    
    # Checkout route
    resource :checkout, only: [:show]
  end
  
  # Standalone route for removing item from cart
  delete '/users/cart/remove_item/:id', to: 'users/carts#remove_item', as: 'remove_item_from_cart' # Renamed to ensure uniqueness

end
