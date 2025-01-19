Rails.application.routes.draw do
  root to: 'dashboard#index'

  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  resources :stores do
    member do
      patch :update_rating
    end
  end
  resources :ratings
  resources :users

  post 'dashboard/assign_store_admin', to: 'dashboard#assign_store_admin', as: 'assign_store_admin_dashboard'

  get '/signup', to: 'sessions#signup', as: 'signup'
  post '/register', to: 'sessions#register', as: 'register'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get 'up' => 'rails/health#show', as: :rails_health_check

  get '/rating', to: 'ratings#index'
end
