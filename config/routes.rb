Rails.application.routes.draw do
  resources :inquiries
  resources :houses
  resources :househunters
  resources :realtors
  resources :companies
  resources :users

  get    '/login',   to: 'login#new'
  post   '/login',   to: 'login#create'
  get    '/logout', to: 'login#destroy'
  get    '/rel_houses', to: 'houses#realtorhouses'
end
