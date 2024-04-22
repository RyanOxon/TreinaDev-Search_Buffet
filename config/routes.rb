Rails.application.routes.draw do
  root to: 'home#page'
  devise_for :buffet_owners
  resources :buffets, only: [:edit, :update, :show, :create, :new]
  resources :events, only: [:edit, :update, :show, :create, :new, :index]
  resources :event_prices, only: [:edit, :update, :new, :create]
end