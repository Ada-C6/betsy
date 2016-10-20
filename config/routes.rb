Rails.application.routes.draw do

root to: 'products#index'

  resources :products do
    resources :reviews
  end

    resources :categories
    resources :guests
    resources :merchants
    resources :orders


  get 'sessions/create'

  get 'sessions/destroy'

  get 'merchants/:id/products' => 'merchants#show_merchant_products', as: 'merchant_products'


  get "/auth/:provider/callback" =>  "sessions#create"

end
