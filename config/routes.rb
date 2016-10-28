Rails.application.routes.draw do

  # omniauth route
  get "/auth/:provider/callback" =>  "sessions#create", as: 'create'

  get "logout" => "sessions#destroy", as: "logout"

  root to: 'pages#index'

  resources :products, except: [:destroy] do
    resources :reviews
  end

  resources :users, :categories, :orders, :addresses, :order_products

  get 'addresses/new/:redirect_to' => 'addresses#new', as: 'address_new'

  get 'cart' => 'pages#cart', as: 'cart'

  get 'account' => 'users#show', as: 'account'

  get 'account/edit' => 'users#edit', as: 'account_edit'

  put 'account/update' => 'users#update', as: 'account_update'

  patch 'toggle/:id' => 'users#switch_active', as: 'toggle'

  patch 'toggle_product/:id' => 'products#switch_active', as: 'toggle_product'

  get 'users/orders/:id' => 'orders#all', as: 'user_orders'
end
