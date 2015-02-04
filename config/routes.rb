Rails.application.routes.draw do
  
  root to: 'users#new'

  resources :courses, only: [:new, :create, :show] do
  end
  
  resources :users, only: [:create, :show]
  
  get '/register', to: 'users#new'  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
    
end
