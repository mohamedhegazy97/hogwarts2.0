Rails.application.routes.draw do
  default_url_options :host => "localhost:3000"
  #get 'password_resets/new'
  #post 'password_resets/create'
  #get 'password_resets/edit'
  #post 'password_resets/update'
  get 'sessions/new'
  get 'users/new'
  root 'static_pages#home'
  get '/help',to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :password_resets,only: [:new, :create, :edit, :update]
  resources :spells,only: [:create, :destroy]
  resources :relationships,only: [:create, :destroy]
  end