Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"

  devise_for :users

  resources :teams

  root to: 'pages#home'

end
