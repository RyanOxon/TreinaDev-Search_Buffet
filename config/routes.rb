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

  resources :orders, only: [:show]

  resources :event_prices, only: [:edit, :update, :new, :create]
end