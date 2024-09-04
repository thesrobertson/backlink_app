Rails.application.routes.draw do
  root 'users#new'  # Root URL for user email input
  get '/login', to: 'sessions#new'  # Admin login page
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/admin/dashboard', to: 'admin#dashboard'  # Admin dashboard

  resources :backlinks
  resources :users, only: [:new, :create]  # Only new and create actions for users
end