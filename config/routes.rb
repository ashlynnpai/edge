Rails.application.routes.draw do
  
  root to: 'statics#index'

  resources :courses, only: [:index, :new, :create, :show] do
    resources :reviews, only: [:create, :edit, :update]
    resources :posts, only: [:create, :edit, :update, :show]
  end
  
  resources :posts, only: [:create, :edit, :update, :show] do
    resources :replies, only: [:create, :edit, :update]
  end
  
  #resources :replies, only: [:create]
  #http://weblog.jamisbuck.org/2007/2/5/nesting-resources
  

  get 'study_hall/:id', to: 'courses#study_hall', as: 'study_hall'
  post 'add_course_status', to: 'courses#add_course_status'
  
  
  resources :users, only: [:create, :show] do
    member do
      get 'transcript'
    end
  end
  
  patch 'make_private', to: 'users#make_private'
  
  get '/register', to: 'users#new'  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  resource :dashboard, only: [:show]

  
  resources :categories, only: [:new, :create, :show] 
  
  resources :courseitems, only: [:index, :create]
  
  resources :badgeinputs, only: [:new, :create, :show]
      
end
