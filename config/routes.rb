Rails.application.routes.draw do


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
