Rails.application.routes.draw do
  root 'pages#home'

  resources :work_permits
  resources :companies, only: %i[new create]

  devise_for :users, controllers: { sessions: 'users/sessions' }
end
