Rails.application.routes.draw do
  resources :users
  root 'top#index'
  
  resources :welcomes, only: :index
  resource :login, only: [:new, :create]
  resource :logout, only: [:show]
end
