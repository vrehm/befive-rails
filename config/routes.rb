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
      collection do
        resources :participations, only: [ :create, :update, :destroy ]
      end
    end

    resources :members, only: [ :create, :update, :destroy ]
    resources :relationships, only: [ :create, :destroy ]
    
    end
    root to: 'pages#home'

  end
end
