Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root   'welcome#index'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get ':id', to: 'users#show', as: 'show'
  resources :users, path: '/' do 
    member do
      get :following, :followers
    end
  end
  #resources :account_activations, only: [:edit] # TODO
  resources :password_resets, only: [:new, :create, :edit, :update] # TODO
  resources :microposts, only: [:create, :destroy]
end
