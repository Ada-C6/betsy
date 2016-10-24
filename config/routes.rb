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

  #============== Products ==================

  get 'products/index' => 'products#index', as: 'index_products'

  get 'products/by_seller' => 'products#by_seller_products', as: 'by_seller_products'

  get 'products/show/:id' => 'products#show', as: 'show_products'


  get 'products/new' => 'products#new', as: 'new_products'

  post 'products/create' => 'products#create', as: 'create_products'

  get 'products/:id/edit' => 'products#edit', as: 'edit_products'

  patch 'products/:id/update' => 'products#update', as: 'update_products'

  delete 'products/:id/destroy' => 'products#destroy', as: 'destroy_products'

  #============== Sessions ==================

  # get 'login' => 'sessions#new'
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

  get 'orders/index' => 'orders#index', as: 'index_orders'

  get 'orders/show/:id' => 'orders#show', as: 'show_orders'

  get 'orders/new' => 'orders#new', as: 'new_orders'

  post 'orders/create' => 'orders#create', as: 'create_orders'

  get 'orders/:id/edit' => 'orders#edit', as: 'edit_orders'

  patch 'orders/:id/update' => 'orders#update', as: 'update_orders'

  delete 'orders/:id/destroy' => 'orders#destroy', as: 'destroy_orders'

end
