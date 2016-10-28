Rails.application.routes.draw do
  root 'drinks#index'
  get '/drinks', to: 'drinks#index'

  # @TODO - remove below route; it's redundant due to resources :products
  # get '/products/:id', to: 'products#show'

  # @TODO - clarify & refactor '/products' route - there are currently two routes for this path: here (pointing to 'products#popular') & in the resources routes (pointing to 'products#index') - ks
  get '/products', to: 'products#popular', as: 'popular'
  get '/search', to: 'products#category', as: 'by_category'
  get '/auth/:provider/callback', to: "sessions#create"
  get '/sessions', to: 'sessions#index', as: 'sessions'
  get '/sessions/new', to: 'sessions#new', as: 'login'
  get '/sessions/login_failure', to: 'sessions#login_failure', as: 'login_failure'
  delete '/sessions', to: 'sessions#destroy', as: 'logout'
  get '/user/:id/order_items/:product_id', to: 'user#order_items', as: 'user_order_items'
  get 'orders/:id/checkout', to: 'orders#checkout', as: 'checkout_order'

  patch '/orders/:order_id/order_items/:id/ship', to: 'order_items#ship', as: 'ship_item'

  patch '/products/:id/:productstatus', to: 'products#retire', as: 'productstatus' #EN retire or activate product

  resources :products do
    resources :reviews, only: [:new, :create]
  end

  get 'products/:user_id', to: 'products#seller', as: 'search_sellers_products'

  resources :categories

  resources :users do
    resources :products, except: [:index, :show]
  end

  resources :orders do
    resources :order_items, only: [:create, :update, :destroy]
  end


  # This path may not be RESTful; could be nice to have ultimately, or could be deleted after testing - ks
  get '/cart', to: 'orders#cart', as: :cart



#route to show the products of a user for a public guest...maybe change this? dkl
  get '/user/:id/products', to: 'users#public_show', as: 'users_products'

#order cofirmation page for guest user

get 'orders/:id/confirmation', to: 'orders#confirmation', as: 'confirmation'

get '/users/:id/:orderstatus', to: 'users#show', as: 'orderstatus' #EN


  # resources :users, shallow: do
  #   resources :products do
  #     resources :order_items
  #   end
  # end


  # Use match or shallow routing with nested products for @user


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
