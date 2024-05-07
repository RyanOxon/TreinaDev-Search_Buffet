Rails.application.routes.draw do
  root to: 'buffets#index'
  
  devise_for :customers, controllers: {
    registrations: 'customers/registrations'
  }
  
  devise_for :buffet_owners

  resources :buffets, only: [:edit, :update, :show, :create, :new, :index] do
    get 'search', on: :collection
  end

  resources :events, only: [:edit, :update, :show, :create, :new, :index] do
    resources :orders, only: [:new, :create]
  end

  resources :orders, only: [:show, :index] do
    resources :service_proposals, only: [:create, :update]
    member do
      post :accept_proposal
      post :reject_proposal
      post :cancel
    end
  end

  resources :event_prices, only: [:edit, :update, :new, :create]

end