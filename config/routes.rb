Rails.application.routes.draw do
  root 'top#index'

  resources :welcomes, only: :index
end
