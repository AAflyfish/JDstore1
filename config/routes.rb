Rails.application.routes.draw do
  devise_for :users
  resources :carts do
    collection do
      delete :clean
      post :checkout
    end
  end

  resources :cart_items
  root 'products#index'
  namespace :admin do
    resources :products do
      member do
        post :move_up
        post :move_down
      end
    end
  end

  resources :products do
    member do
      post :add_to_cart
    end
  end
  resources :orders
  namespace :account do
    resources :orders
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
