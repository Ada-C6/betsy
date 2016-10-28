Rails.application.routes.draw do
  root "home#index"

  resources :categories, only: [:index, :show, :new, :create] do
    resources :products, only: [:index, :show]
  end

  resources :orders, only: [:new, :create]
  get "order" => "orders#show"
  get "orders/edit" => "orders#edit"
  patch "orders/update" => "orders#update"
  get "orders/confirmation" => "orders#purchase", as: "confirmation"
  patch "orders/ship" => "orders#ship", as: "ship"

  resources :products, only: [:index, :show] do
    resources :order_items, only: [:create]
    resources :reviews, only: [:index, :show, :new, :create]
  end
  get 'products/:id/add_to_cart' => "products#add_to_cart", as: "add_to_cart"
  patch "products/:id/add_to_cart" => "products#add_to_cart"


  resources :merchants, only: [:show, :index] do
    get 'orders/:id' => 'orders#merchant_view', as: 'orders'
    resources :products, except: [:delete] do
      resources :reviews, only: [:show, :new, :create,:index]
    end
    resources :categories, except: [:edit, :update, :delete]
    # resources :orders, only: [:merchant_view]
  end


  # get 'merchants/:merchant_id/products/:id', to: 'products#show', as: 'merchant_product'

  get "/auth/:provider/callback" =>  "sessions#create"

  get "/sessions/login_failure", to: "sessions#login_failure", as: "login_failure"
  # get "sessions" => "sessions#index"
  delete "sessions", to: "sessions#destroy"

  resources :order_items, only: [:destroy, :update]
end
