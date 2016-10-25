Rails.application.routes.draw do

  root 'main#index'

  get "/auth/:provider/callback" => "sessions#create"

  get "/sessions/login_failure", to: "sessions#login_failure", as: "login_failure"
  get "/sessions", to: "sessions#index", as: "sessions"
  delete "/sessions", to: "sessions#destroy"

  resources :merchants, except: [:destroy] do
	   resources :products, only: [:new, :create]
  end
  #add non-restful route orders where merchant id

  resources :products, except: [:new, :create, :destroy] do
  	resources :reviews, except: [:update, :destroy, :edit]
    resources :orders, only: [:create]
  end
  patch 'products/:id/retired', to: 'products#retired', as: 'product_retired'


  resources :categories, except: [:destroy, :edit, :update]

  resources :orders, except: [:destroy, :index, :new, :create]

  # post 'products/:id/orders', to: 'orders#create'

  patch 'orders/:id/completed', to: 'orders#completed', as: 'order_completed'
  patch 'orders/:id/cancelled', to: 'orders#cancelled', as: 'order_cancelled'
  patch 'orders/:id/paid', to: 'orders#paid', as: 'order_paid'


  # RELATIONSHIP TABLE ROUTES
  resources :order_items, only: [:destroy, :create, :update]
  patch 'order_items/:id/shipped', to: 'order_items#shipped', as: 'order_items_shipped'


  resources :product_categories, only: [:create, :destroy]



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
