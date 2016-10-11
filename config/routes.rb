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
    put 'participation/:id/select', to: 'participations#select', as: :select
    patch 'participation/:id/unselect/', to: 'participations#unselect', as: :unselect
    patch 'participations/:event_id', to: 'participations#sent', as: :sent
    get 'participation/:id/refused', to: 'participations#refused', as: :refused
    get 'participation/:id/validated', to: 'participations#validated', as: :validated
    root to: 'pages#home'
  end
end
