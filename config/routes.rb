Rails.application.routes.draw do
  root 'pages#home'

  resources :work_permits
  resources :companies, only: %i[new create]

  namespace :api do
    get '/badge', to: 'pages#badge'
  end

  devise_for :users, controllers: { sessions: 'users/sessions' }
end
