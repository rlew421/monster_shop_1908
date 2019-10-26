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
  put '/profile/:user_id', to: 'users#update'
  get '/profile/:user_id/edit/password', to: 'users#edit'
  patch '/profile/:user_id/password', to: 'users#update'

  namespace :admin do
    get '/users', to: 'dashboard#index'
    get '/users/:user_id/edit', to: 'users#edit'
    get '/users/:user_id/edit/password', to: 'users#edit'
    put '/users/:user_id', to: 'users#update'
    patch '/users/:user_id/password', to: 'users#update'
    get '/:admin_id', to: 'dashboard#show'
    get '/users/:user_id/upgrade_merchant_employee', to: 'users#upgrade'
    get '/users/:user_id/upgrade_merchant_admin', to: 'users#upgrade'
  end

  namespace :merchant do
    get '/:merchant_id', to: 'dashboard#show'
  end
end
