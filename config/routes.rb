Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "flashes#index"
  resources :users, only: [:index]
  resources :expenses, only: [:new, :create, :edit, :update, :destroy, :show]
  resources :categories, only: [:index, :new, :create, :edit, :update, :destroy, :show] 
  resources :flashes, only: [:index]
  resources :incomes, only: [:new, :create] 
  resources :incomes do
    collection do
      post 'clear_all'
    end
  end 

  authenticated :user do
    root 'categories#index', as: :authenticated_root
  end
  
  unauthenticated do
    root 'flashes#index', as: :unauthenticated_root
  end
end