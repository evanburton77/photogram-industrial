Rails.application.routes.draw do
  root "photos#index"

  resources :likes
  resources :follow_requests
  resources :comments
  resources :photos

  devise_for :users

  post "follow_requests" => "follow_requests#create", as: :follow_create
  patch "follow_requests/:id" => "follow_requests#update", as: :follow_update
  get ":username/liked" => "photos#liked", as: :liked_photos
  get ":username/feed" => "photos#feed", as: :feed_photos
  get ":username/discover" => "photos#discover", as: :discover_photos
  get ":username/followers" => "users#followers", as: :followers
  get ":username/following" => "users#following", as: :following
  get ":username/pending" => "users#pending", as: :pending
  get ":username" => "users#show", as: :user

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
