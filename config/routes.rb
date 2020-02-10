Rails.application.routes.draw do
  root to: 'home_page#home'

  get '/signup', to: 'users#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :articles
  resources :categories

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
