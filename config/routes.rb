Rails.application.routes.draw do
  resources :groups
  resources :expenses
  resources :users, except: [:new]
  root 'welcome#index'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'external', to: 'expenses#external'
end
