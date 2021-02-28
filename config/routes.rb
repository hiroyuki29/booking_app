Rails.application.routes.draw do
  get "/" => "home#top"
  get "users/edit" => "users#edit"
  patch "users/update" => "users#update"
  get "users/account" => "users#account"
  get "users/profile" => "users#profile"
  patch "users/profile_update" => "users#profile_update"
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "rooms/search" => "rooms#search"
  get "books/index" => "books#index"
  get "books/show/:book_id" => "books#show"

  resources :users, except: [:edit, :update, :destory]
  resources :rooms do
    resources :books, only: [:create]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
