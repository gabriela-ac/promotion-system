Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :promotions, only: %i[index show new create] do
    post 'generate_coupons', on: :member
  end
  resources :product_categories, only: %i[index]
end
