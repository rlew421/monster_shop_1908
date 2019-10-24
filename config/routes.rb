Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: "welcome#index"

  resources :merchants do
    resources :items, only: [:index, :new, :create]
  end

  resources :items, except: [:new, :create] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:edit, :update, :destroy]
  resources :orders, only: [:new, :create, :show]

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "/cart/:item_id/:increment_decrement", to: "cart#increment_decrement"

  get "/orders/new", to: "orders#new"
  post "/orders", to: "orders#create"
  # get "/orders/:id", to: "orders#show"

  delete '/cancel/:order_id', to: 'orders#destroy'




  get '/profile/orders', to: 'orders#index'
  get '/profile/orders/:order_id', to: 'orders#show'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/profile/:user_id', to: 'users#show'
  get '/profile/:user_id/edit', to: 'users#edit'
  patch '/profile/:user_id', to: 'users#update'

  namespace :admin do
    get '/users', to: 'dashboard#index'
    get '/:admin_id', to: 'dashboard#show'
  end

  namespace :merchant do
    get '/:merchant_id', to: 'dashboard#show'
  end
end
