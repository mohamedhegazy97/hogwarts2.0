Rails.application.routes.draw do
  default_url_options :host => "localhost:3000"
  get 'sessions/new'
  get 'users/new'
  root 'static_pages#home'
  get '/help',to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  #post '/spells' to: 'spells#edit'
  #post '/edit', to: 'spells#edit'
  post '/spells/:id' ,to: 'spells#edit'
  #get '/spells/:id/edit', to: 'spells#edit'
  #put '/spells/:id', to: 'spells#update'
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :password_resets,only: [:new, :create, :edit, :update]
  resources :spells#,only: [:create, :destroy , :update]
  resources :relationships,only: [:create, :destroy]
  end