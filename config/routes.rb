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

    resources :events
    resources :members, only: [ :create, :update, :destroy ]
    resources :relationships, only: [ :create, :destroy ]
    put 'participation/:id', to: 'participations#select', as: :select
    patch 'participation/:id', to: 'participations#unselect', as: :unselect
    patch 'participations/:event_id', to: 'participations#sent', as: :sent
    get 'participation/:id', to: 'participations#validated', as: :validated
    get 'participation/:id', to: 'participations#refused', as: :refused
    root to: 'pages#home'
  end
end
