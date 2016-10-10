Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"

  devise_for :users

  scope '(:locale)', locale: /fr|en/ do

    resources :teams do
      collection do
        get 'search', to: "teams#search"
      end
      resources :invitations, only: [ :create, :new ]
    end

    resources :events do
      resources :participations, only: [ :index, :create, :update, :destroy ]
    end

    resources :members, only: [ :create, :update, :destroy ]
    resources :relationships, only: [ :create, :destroy ]
    root to: 'pages#home'
  end
end
