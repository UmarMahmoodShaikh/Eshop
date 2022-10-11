require 'sidekiq/web'
Rails.application.routes.draw do
  resources :chats
  devise_for :users
  devise_scope :user do
    get "users/sign_out", to: "devise/sessions#destroy"
    post "session/user", to: "devise/sessions#create"
  end

  mount Sidekiq::Web => '/sidekiq'
  resources :retailers
  resources :carts
  resources :orders
  resources :addresses
  resources :shoppers
  resources :subcategories
  resources :categories
  resources :brands
  resources :companies
  resources :session
  resources :products do
    collection do
      get :search
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #FOR API CALLS 
  namespace :api do
  end
  # Defines the root path route ("/")
  get '/' => 'users#index' 

  post'/sessions' => 'xyz#index'

  mount API::Base => '/'
  
  mount ActionCable.server => '/cable'
  
  #Grapes ROUTES
  # mount Eshop::Base => '/api'
  #mount Eshop::Base => '/api'
  # get '/API/V1/products' => 'API/V1/products'
end
