Rails.application.routes.draw do
  resources :users
  root 'top#index'

  resources :welcomes, only: :index
end
