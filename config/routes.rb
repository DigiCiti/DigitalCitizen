Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create, :show]
  get '/users/hub/:id', to: 'users#hub', as: :hub

  resources :friendships, only: [:create, :update, destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :quiz_responses, only: [:new, :create, :show]
  resources :congress_members, only: [:show]
  # get '/congress_members/:id', to: 'congress_members#show'

  root 'users#new'
end
