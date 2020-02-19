Rails.application.routes.draw do
  root to: 'home_page#home'

  get '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get 'published_articles', to: 'articles#published_articles'
  get 'saved_articles', to: 'articles#saved_articles'
  get 'bookmarks', to: 'articles#bookmarks'
  get 'search', to: 'articles#search'

  get 'profile', to: 'users#show'
  get '/edit_profile', to: 'users#edit'

  resources :users, except: [:show, :edit]
  resources :articles, except: [:index]
  resources :categories, only: [:index, :new, :create, :destroy]
  resources :comments, only: [:new, :create]
  resources :votes, only: [:index, :create, :destroy]
  resources :bookmarks, only: [:index, :create, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
