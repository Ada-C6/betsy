Rails.application.routes.draw do
  root to: 'landing#index'

  get 'landing/index' => 'landing#index', as: 'index'

  get "/auth/:provider/callback" =>  "sessions#create"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'


  resources :merchants do
    resources :products do
      resources :reviews
    end
  end
  delete 'merchants/sessions/destroy' => 'sessions#destroy'
    resources :categories
    resources :guests
    #resources :merchants
    resources :orders do
      post 'update_qty'
      get 'checkout'
    end

  get 'sessions/create'

  delete 'sessions/destroy' => 'sessions#destroy'

  get 'products/all_products' => 'products#all_products', as: 'all_products'
  post 'orders/add_to_cart' => 'orders#add_to_cart', as: 'add_to_cart'
  # get 'orders/view_cart' => 'orders#view_cart', as: view_cart

  # get 'merchants/:id/products' => 'merchants#show_merchant_products', as: 'merchant_products'


end
