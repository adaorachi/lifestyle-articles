Rails.application.routes.draw do
  root to: 'home_page#home'

  get '/signup', to: 'users#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users, except: [:show, :edit]
  resources :articles do
    post :increment 
  end

  get 'published_articles', to: 'articles#published_articles'
  get 'saved_articles', to: 'articles#saved_articles'
  get 'bookmarks', to: 'articles#bookmarks'

  get 'profile', to: 'users#show'
  get '/edit_profile', to: 'users#edit'

  resources :categories
  resources :comments
  resources :votes, only: [:index, :create, :destroy]
  resources :bookmarks, only: [:index, :create, :destroy]
  resources :tags

  
  get 'search', to: 'articles#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
