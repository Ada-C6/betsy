Rails.application.routes.draw do

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

  get 'pending_orders' => 'users#pending_orders', as: 'pending_orders'

  get 'paid_orders' => 'users#paid_orders', as: 'paid_orders'

  get 'completed_orders' => 'users#completed_orders', as: 'completed_orders'

  get 'cancelled_orders' => 'users#cancelled_orders', as: 'cancelled_orders'

  #============== Products ==================

  get 'products/index' => 'products#index', as: 'index_products'

  get 'products/:id/show_seller_products' => 'products#show_seller_products', as: 'show_seller_products'

  get 'products/show/:id' => 'products#show', as: 'show_products'

  get 'products/new' => 'products#new', as: 'new_products'

  post 'products/create' => 'products#create', as: 'create_products'

  get 'products/:id/edit' => 'products#edit', as: 'edit_products'

  patch 'products/:id/update' => 'products#update', as: 'update_products'

  delete 'products/:id/destroy' => 'products#destroy', as: 'destroy_products'

  #============== Sessions ==================

  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

#   get 'sessions/index' => 'sessions#index', as: 'index_sessions'

#   get 'sessions/show/:id' => 'sessions#show', as: 'show_sessions'

#   get 'sessions/new' => 'sessions#new', as: 'new_sessions'

  get "/auth/:provider/callback" =>  "sessions#create"
# #the below route was not right.  we used the above route in class.
#   # post 'sessions/create' => 'sessions#create', as: 'create_sessions'

#   get 'sessions/:id/edit' => 'sessions#edit', as: 'edit_sessions'

#   patch 'sessions/:id/update' => 'sessions#update', as: 'update_sessions'

  # delete 'sessions/:id/destroy' => 'sessions#destroy', as: 'destroy_sessions'

  resources :sessions

  #============== Orders ==================


  post 'cart/add_to_cart' => 'orders#add_to_cart', as: 'add_to_cart'

  get 'cart' => 'orders#show_cart', as: 'show_cart'

  post 'order_item/change_quantity' => 'orders#change_quantity', as: 'change_quantity'

  delete 'order_item/delete' => 'orders#destroy_order_item', as: 'destroy_order_item'

  get 'checkout' => 'orders#checkout', as: 'checkout'

  post 'orders/create' => 'orders#create_order', as: 'create_order'

  get 'orders/:order_id/confirmation' => 'orders#confirmation', as: 'confirmation'

  patch 'orders/:order_id/cancel' => 'orders#cancel_order', as: 'cancel_order'


  get 'orders/index' => 'orders#index', as: 'index_orders'

  get 'orders/show/:id' => 'orders#show', as: 'show_orders'

  get 'orders/new' => 'orders#new', as: 'new_orders'


  get 'orders/:id/edit' => 'orders#edit', as: 'edit_orders'

  patch 'orders/:id/update' => 'orders#update', as: 'update_orders'



end
