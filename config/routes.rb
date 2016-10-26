Rails.application.routes.draw do


  root "homepages#index"

  get 'homepages/index'

  get 'homepages/show'

  # Orderitems controller

  post 'orderitems/:product_id/create' => 'orderitems#create', as: 'orderitems_create'

  patch 'orderitems/:id/update' => 'orderitems#update', as: 'orderitems_update'

  delete 'orderitems/:id/destroy' => 'orderitems#destroy', as: 'orderitems_destroy'

  # Carts controller

  get 'carts/index'

  get 'carts/show'

  get 'carts/edit'

  put 'carts/update'

  get 'carts/update' # To deal with refresh

  get 'carts/new'

  post 'carts/create'

  delete 'carts/destroy'

  # Stores controller (for user-facing merchant-based display of products)

  get 'stores/index'

  get 'stores/show/:id' => "stores#show", as: "stores_show"


  # Orders controller

  get 'orders/index' => 'orders#index', as: "orders_index"

  get 'orders/new'

  get 'orders/:product_id/create' => 'orders#create', as: 'orders_create'

  get 'orders/:product_id/update' => 'orders#update', as: 'orders_update'

  get 'orders/:id/show' => 'orders#show', as: 'orders_show'

  get 'orders/destroy'

  # merchant controller

  get 'merchants/index' => 'merchants#index', as: 'merchants_index'

  get 'merchants/show'

  get 'merchants/new'

  get 'merchants/create'

  get 'merchants/:id/edit' => 'merchants#edit', as: 'merchants_edit'

  patch 'merchants/:id/update' => 'merchants#update', as: 'merchants_update'


  # Products controller routes

  get 'products/index'

  get 'products/:id/reviews/new' => 'reviews#new', as: "reviews_new"

  post 'products/:id/reviews/create' => 'reviews#create', as: "reviews_create"

  get 'products/:id/edit' => 'products#edit', as: 'products_edit'

  patch 'products/:id/update' => 'products#update', as: 'products_update'

  get 'products/show/:id' => "products#show", as: "products_show"

  post 'products/new' => "products#new", as: "products_new"

  post 'products/create'



  patch 'products/:id/retire' => 'products#retire', as: "products_retire"

  # sessions controller

  get 'sessions/create'

  get 'sessions/index'

  delete 'sessions/:id/destroy' => 'sessions#destroy', as: 'session_delete'

  # Categories controllers

  get 'categories/index'

  get 'categories/new'

  get 'categories/create'

  get 'categories/show/:id' => "categories#show", as: "categories_show"

  get 'categories/destroy'

  get "/auth/:provider/callback" =>  "sessions#create"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
