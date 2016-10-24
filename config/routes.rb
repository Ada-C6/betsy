Rails.application.routes.draw do

    root 'home#index'

    resources :merchants, only: [:index, :show]

    resources :products do
        resources :reviews, only: [:new, :create]
    end


    resources :orders, except: [:new, :create, :delete]
    resources :order_items, except: [:index, :show]
    resources :categories, only: [:index, :new, :create, :show]

# We're going to talk about this more if any of us needs to edit this. :)
    # resources :orders, only: [:new, :create, :show] do
    #     # resources :order_items, except: [:index, :show]
    # end

# Sessions routes - can be further flushed out...
    get '/auth/:provider/callback' =>  'sessions#create'

    get "/sessions/login_failure", to: "sessions#login_failure", as: "login_failure"

    get '/sessions', to: 'sessions#index', as: 'portal'

    delete '/sessions', to: 'sessions#destroy'

end
