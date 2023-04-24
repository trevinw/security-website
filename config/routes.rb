Rails.application.routes.draw do
  root 'pages#home'

  resources :companies, only: %i[new create]
  resources :deliveries
  resources :work_permits

  get '/badge', to: 'pages#badge'

  namespace :api do
    get '/badge', to: 'pages#badge'
  end

  devise_for :users, controllers: { sessions: 'users/sessions' }
end
