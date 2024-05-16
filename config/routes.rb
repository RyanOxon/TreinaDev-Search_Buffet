Rails.application.routes.draw do
  root to: 'buffets#index'
  
  devise_for :customers, controllers: {
    registrations: 'customers/registrations'
  }
  
  devise_for :buffet_owners

  resources :buffets, only: [:edit, :update, :show, :create, :new, :index] do
    resources :rates, only: [:show, :new, :create, :index]
    member do
      post :disable
      post :activate
    end
    get :search, on: :collection
  end

  resources :rates, only: [] do
    resources :holder_images, only: [:create, :destroy]
  end

  resources :events, only: [:edit, :update, :show, :create, :new, :index] do
    resources :orders, only: [:new, :create]
    resources :holder_images, only: [:create, :destroy]
    member do
      post :disable
      post :activate
      post :cover
    end
  end
  resources :event_prices, only: [:edit, :update, :new, :create]

  resources :orders, only: [:show, :index] do
    resources :messages, only: [:create]
    resources :service_proposals, only: [:create, :update]
    member do
      post :accept_proposal
      post :reject_proposal
      post :cancel
    end
  end

  namespace :api do
    namespace :v1 do
      resources :buffets, only: [:show, :index] do
        resources :events, only: [:index] do
          get :availability, on: :member
        end
      end
    end
  end
end