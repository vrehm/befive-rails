Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"

  devise_for :users

  resources :teams
  resources :members, only: [ :create, :update, :destroy ]

  root to: 'pages#home'

end
