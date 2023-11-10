Rails.application.routes.draw do
  resources :tasks
  resources :users
  root 'top#index'
  
  resources :welcomes, only: :index
  resource :login, only: [:new, :create]
  resource :logout, only: [:show]
end
