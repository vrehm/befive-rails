Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"

  devise_for :users

  scope '(:locale)', locale: /fr|en/ do
    resources :teams
    resources :members, only: [ :create, :update, :destroy ]

    root to: 'pages#home'
  end
end
