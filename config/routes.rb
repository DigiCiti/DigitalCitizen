Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :index, :create, :show, :edit, :update, :destroy]
  get '/users/hub/:id', to: 'users#hub', as: :hub
  get '/users/welcome', to: 'users#welcome', as: :welcome #needs fix, routes to show

  resources :friendships, only: [:create, :update, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :quiz_responses, only: [:new, :create, :show]
  resources :congress_members, only: [:index, :show]
  resources :entries, only: [:new, :create, :edit, :update, :destroy]
  resources :comments, only: [:new, :create, :edit, :update, :destroy]

  root 'users#new'
end
