Rails.application.routes.draw do

  get "/auth/:provider/callback" =>  "sessions#create"


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root to: 'products#index'
    resources :categories
    resources :guests
    resources :merchants
    resources :products
    resources :reviews
    resources :orders


  get 'sessions/create'

  get 'sessions/destroy'


  get "/auth/:provider/callback" =>  "sessions#create"

end
