Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'sessions/new'
  get '/timeline', to: 'home#timeline'
  get '/signup', to: 'users#new'
  get '/login', to: 'users#new'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users
end
