Rails.application.routes.draw do
  root 'sessions#index_log_out'
  get "/auth/:provider/callback" =>  "sessions#create"
  get "/sessions/", to: "sessions#index_log_in", as: "sessions_log_in"
  get "/sessions/", to: "sessions#index_log_out", as: "sessions_log_out"
  delete "/sessions", to: "sessions#destroy"
  get "/sessions/merchant_login", to: "sessions#merchant_login", as: "sessions_merchant_login"

  resources :orders do
    resources :order_items, except: [:update, :destroy, :show]
    resources :payment_details, only: [:new, :create]
  end

  get "/cancel", to: "orders#cancel", as: "cancelled_order"

  resources :order_items, only: [:update, :destroy, :show]
  patch "/order_items/:id/ship", to: 'order_items#ship', as: 'ship_order_item'

  resources :payment_details, only: [:show]

  resources :products, except: [:destroy] do
    resources :reviews, only: [:new, :create]
  end

  resources :merchants, only: [:index, :show]
  resources :categories, except: [:edit, :update, :destroy]
end
