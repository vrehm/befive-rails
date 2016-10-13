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
    get 'participations/:event_id', to: 'participations#select_all', as: :select_all
    patch 'participations/:event_id', to: 'participations#send_all', as: :send_all
    get 'participation/:id/refuse', to: 'participations#refuse', as: :refuse
    get 'participation/:id/validate', to: 'participations#validate', as: :validate
    get 'participation/:id/waiting_list', to: 'participations#waiting_list', as: :waiting_list
    root to: 'pages#home'
  end
end
