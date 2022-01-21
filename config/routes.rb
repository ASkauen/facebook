Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  resources :users, only: [:show, :update]
  resources :posts
  resources :friendships, only: [:destroy]
  resources :friend_requests, only: [:create, :destroy] do
    post "/accept", to: "friend_requests#accept", on: :member
  end
  root 'posts#index'
  get "/auth/facebook/callback", to: "omniauth#facebook"
  patch "/update_avatar/:id", to: "users#update_avatar", as: "update_avatar"
end
