Rails.application.routes.draw do

  resources :courses, only: [:new, :create, :show] do
    
  end
end
