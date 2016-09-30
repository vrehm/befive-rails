Rails.application.routes.draw do

  devise_for :users

  resources :teams

  root to: 'pages#home'
  
end
