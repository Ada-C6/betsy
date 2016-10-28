Rails.application.routes.draw do

  get 'reviews/index' => 'reviews#index', as: 'index_reviews'

  get 'reviews/show/:id' => 'reviews#show', as: 'show_reviews'

  get 'products/:id/reviews/new/' => 'reviews#new', as: 'new_reviews'

  post 'products/:id/reviews/create' => 'reviews#create', as: 'create_reviews'

  get 'reviews/edit'

  get 'reviews/update'

  delete 'reviews/:id/destroy' => 'reviews#destroy', as: 'destroy_reviews'

# we chose to make the convention of having the as: be action + plural.

  root to: 'homepages#index'
  get 'homepages/index' => 'homepages#index', as: 'index'

  get 'homepages/:category/show_category' => 'homepages#show_category', as: 'show_category'

  # get 'homepages/new' => 'homepages#new', as: 'new_homepages'
  #
  # post 'homepages/create' => 'homepages#create', as: 'create_homepages'
  #
  # get 'homepages/edit' => 'homepages#edit', as: 'edit_homepages'
  #
  # patch 'homepages/update' => 'homepages#update', as: 'update_homepages'
  #
  # delete 'homepages/destroy' => 'homepages#destroy', as: 'destroy_homepages'

  #============== Users ==================

  resources :users

  get 'user_account' => 'users#user_account', as: 'user_account'

  get 'buyer_manage' => 'users#buyer_manage', as: 'buyer_manage'

  get 'seller_manage' => 'users#seller_manage', as: 'seller_manage'

  get 'orders_by_status/:status/' => 'users#show_orders_by_status', as: 'show_orders_by_status'

  get 'get_order_by_status/:status/' => 'users#get_order_by_status', as: 'get_order_by_status'

  patch 'ship_order_item' => 'users#ship_order_item', as: 'ship_order_item'

  get 'order_by_seller/:order_id' => 'users#order_by_seller', as: 'order_by_seller'

  #============== Products ==================

  get 'products/index' => 'products#index', as: 'index_products'

  get 'products/:id/show_seller_products' => 'products#show_seller_products', as: 'show_seller_products'

  get 'products/show/:id' => 'products#show', as: 'show_products'

  get 'products/new' => 'products#new', as: 'new_products'

  post 'products/create' => 'products#create', as: 'create_products'

  get 'products/:id/edit' => 'products#edit', as: 'edit_products'

  patch 'products/:id/update' => 'products#update', as: 'update_products'

  delete 'products/:id/destroy' => 'products#destroy', as: 'destroy_products'

  get 'products/search' => 'products#search', as: 'search_products'




  #============== Sessions ==================

  # get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  get "/auth/:provider/callback" =>  "sessions#create"


  # delete 'sessions/:id/destroy' => 'sessions#destroy', as: 'destroy_sessions'

  resources :sessions

  #============== Orders ==================


  post 'cart/add_to_cart' => 'orders#add_to_cart', as: 'add_to_cart'

  get 'cart' => 'orders#show_cart', as: 'show_cart'

  post 'order_item/change_quantity' => 'orders#change_quantity', as: 'change_quantity'

  delete 'order_item/delete' => 'orders#destroy_order_item', as: 'destroy_order_item'

  get 'checkout' => 'orders#checkout', as: 'checkout'

  patch 'orders/create' => 'orders#create_order', as: 'create_order'

  get 'orders/:order_id/confirmation' => 'orders#confirmation', as: 'confirmation'

  patch 'orders/:order_id/cancel' => 'orders#cancel_order', as: 'cancel_order'


  get 'orders/index' => 'orders#index', as: 'index_orders'

  get 'orders/show/:id' => 'orders#show', as: 'show_orders'

  get 'orders/new' => 'orders#new', as: 'new_orders'


  get 'orders/:id/edit' => 'orders#edit', as: 'edit_orders'

  patch 'orders/:id/update' => 'orders#update', as: 'update_orders'



end
