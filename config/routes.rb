Rails.application.routes.draw do
  get 'dashboard/index'
  get 'home/index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :stores
  resources :ratings
  resources :users

  # Dashboard route
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  # User authentication routes
  get 'signup', to: 'sessions#signup', as: 'signup'
  post 'register', to: 'sessions#register', as: 'register'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Additional custom route for ratings
  get '/rating', to: 'ratings#index'

  # Defines the root path route ("/")
  # root "posts#index"
end
