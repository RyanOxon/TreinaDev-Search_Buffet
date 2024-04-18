Rails.application.routes.draw do
  root to: 'home#page'
  devise_for :buffet_owners
  resources :buffets
end
