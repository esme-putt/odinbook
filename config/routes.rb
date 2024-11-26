Rails.application.routes.draw do
  resources :posts do
    # Nested routes for like/unlike actions
    post 'like', to: 'likes#create'
    delete 'unlike', to: 'likes#destroy'
    resources :comments
  end
  devise_for :users, :controllers => { :registrations => "registrations_mailer" }
  resources :users, only: [:index, :show, :edit, :update, :create] do
    # Nested routes for follow/unfollow actions
    post 'follow', to: 'follows#create'
    delete 'unfollow', to: 'follows#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "posts#index"
end
