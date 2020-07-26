Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  devise_for :users, controllers: {
                       registrations: "registrations",
                     }
  resources :categories
  resources :products
  resources :order_items
  resource :carts, only: [:show]
  resources :orders

  root "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
