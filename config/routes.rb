Rails.application.routes.draw do

    root 'home#index'

    resources :merchants, only: [:index, :show]

    # We want logged in merchants to be able to view ALL products in an index--and to manage only their products, so I'm adding in a products#manage Controller action to create this:


    get '/products/manage', to: 'products#manage', as: 'manage_products'
    get '/orders/manage', to: 'orders#manage', as: 'manage_orders'


    resources :products do
        resources :reviews, only: [:new, :create]
    end

    patch 'products/:id/retire' => 'products#retire', as: :retire_product

    resources :orders

    resources :order_items, except: [:index, :show]
    resources :categories, only: [:index, :new, :create, :show]


    # Sessions routes

    # We're going to talk about this more if any of us needs to edit this. :)
    # resources :orders, only: [:new, :create, :show] do
    #     # resources :order_items, except: [:index, :show]
    # end

    # Sessions routes - can be further flushed out...

    get '/auth/:provider/callback' =>  'sessions#create'
    get "/sessions/login_failure", to: "sessions#login_failure", as: "login_failure"
    get '/sessions', to: 'sessions#index', as: 'portal'
    delete '/auth/logout', to: 'sessions#logout', as: "logout"
    get '/auth/login', to: 'sessions#login', as: 'login'

    #specific routes for the cart!
    get '/carts' => 'carts#index'
    get 'carts/empty_cart' =>'carts#empty_cart'
    get '/carts/:id', to: 'carts#add_to_cart', as: "add_cart"
    patch 'carts/:id', to: 'carts#more_prod', as: 'more_products'
    patch 'carts/:id/reduce', to: 'carts#less_prod', as: 'less_products'
    delete '/carts/:id/delete_product', to: 'carts#delete_product', as: 'delete_products'
    delete '/carts/products/:id', to: 'carts#destroy', as: 'delete_cart'
end
