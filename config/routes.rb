Rails.application.routes.draw do
  # Root route
  root to: 'dashboard#index'

  # Dashboard route for displaying the dashboard page
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  # Define routes for Stores, Ratings, and Users resources
  resources :stores do
    member do
      patch :update_rating
    end
  end
  resources :ratings
  resources :users

  # Custom route for assigning store admin (only for admins)
  post 'dashboard/assign_store_admin', to: 'dashboard#assign_store_admin', as: 'assign_store_admin_dashboard'

  # User authentication routes (for custom SessionsController)
  get '/signup', to: 'sessions#signup', as: 'signup'
  post '/register', to: 'sessions#register', as: 'register'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  # Additional routes for admin-only access (ensure restricted access)
  # namespace :admin do
  #   resources :stores
  #   resources :users
  #   resources :ratings
  # end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Additional custom route for ratings (if necessary)
  get '/rating', to: 'ratings#index'

  # Optional: Default root path route if necessary
  # root "posts#index" (Uncomment and replace with posts if needed)
end
