Rails.application.routes.draw do
  resources :users, except: [:new]
  root 'welcome#index'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
end
