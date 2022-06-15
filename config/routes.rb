Rails.application.routes.draw do
  get "reservation/new"
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  get "users/account"
  get "users/profile"
  get "users/rooms"
  resources :users

  get "/" => "home#top"
  root to: "home#index"

  resources :rooms
  
  resources :rooms do
    collection do
      get "index"
    end
  end

  resources :rooms do
    resources :reservations, only: [:new, :create, :show]
  end
  resources :reservations, only: [:edit, :update, :destroy, :index]

  #resources :reservation


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
