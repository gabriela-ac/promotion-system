Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :promotions, only: %i[index show new create]
  resources :product_categories, only: %i[index]
end
