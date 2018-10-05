Rails.application.routes.draw do
  root :to => "login#new"
  resources :inquiries do
    member do

    end
  end
  resources :houses
  resources :househunters
  resources :realtors
  resources :companies
  resources :users

  get    '/login',            to: 'login#new'
  post   '/login',            to: 'login#create'
  get    '/logout',           to: 'login#destroy'
  get    '/rel_houses',       to: 'houses#realtorhouses'
  post   '/house_interested', to: 'houses#interested'
  get '/inquiry/new/:id', to: 'inquiries#new', as: :test
  get    '/addimage/:id',  to: 'houses#addimages'
  get '/househunter_inquiries/:id', to: 'inquiries#index', as: :househunter_inquiries
  get     '/input', to: "househunters#input"
  get     '/gotosearch', to:"househunters#search"
  get   '/potential',to: "realtors#potential"
end
