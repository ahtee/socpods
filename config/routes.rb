Rails.application.routes.draw do
  root   'welcome#index'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get ':id', to: 'users#show', as: 'show'
  resources :users , path: '/'
  resources :account_activations, only: [:edit]
end
