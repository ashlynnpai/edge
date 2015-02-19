Rails.application.routes.draw do
  
  root to: 'statics#index'

  resources :courses, only: [:index, :new, :create, :show] do
    resources :reviews, only: [:create]
    resources :posts, only: [:create]
  end

  post 'add_course_status', to: 'courses#add_course_status'
  
  
  resources :users, only: [:create, :show] do
    member do
      get 'transcript'
    end
  end
  
  get '/register', to: 'users#new'  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  
  resources :categories, only: [:new, :create, :show] 
  
  resources :courseitems, only: [:index, :create]
      
end
