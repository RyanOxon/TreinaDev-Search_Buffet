Rails.application.routes.draw do
  devise_for :buffet_owners
  root to: 'home#page'
end
