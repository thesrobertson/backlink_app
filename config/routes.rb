Rails.application.routes.draw do
  root 'users#new'  # Root URL for user email input
  get '/login', to: 'sessions#new'  # Admin login page
  post '/login', to: 'sessions#create'
  
  delete '/logout', to: 'sessions#destroy'
   get 'backlinks/by_country', to: 'backlinks#by_country', as: 'backlinks_by_country'
   get 'backlinks/by_category', to: 'backlinks#by_category', as: 'backlinks_by_category'
   get 'backlinks/by_new', to: 'backlinks#by_new', as: 'backlinks_by_new'
     get 'backlinks/by_special', to: 'backlinks#by_special', as: 'backlinks_by_special'
     get 'backlinks/recently_deleted', to: 'backlinks#recently_deleted', as: 'backlinks_recently_deleted'
  
  get '/admin/dashboard', to: 'admin#dashboard'  # Admin dashboard
  get 'backlinks/home', to: 'backlinks#home'

  resources :backlinks
  resources :users
end