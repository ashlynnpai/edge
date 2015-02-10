Rails.application.routes.draw do
  
  root to: 'statics#index'

  resources :courses, only: [:new, :create, :show] do
  end
  
  post 'add_completed_course', to: 'courses#add_completed_course'
  
  resources :users, only: [:create, :show]
  
  get '/register', to: 'users#new'  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
      
end
