Rails.application.routes.draw do
  root 'static_pages#index'

  resources :regions
  resources :stores
  resources :items
end
