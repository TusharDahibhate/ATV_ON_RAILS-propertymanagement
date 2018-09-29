Rails.application.routes.draw do
  resources :inquiries
  resources :houses
  resources :househunters
  resources :realtors
  resources :companies
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
