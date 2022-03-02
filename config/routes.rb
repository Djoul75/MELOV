Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations' }
  root to: 'pages#home'
  # get 'search', to: 'pages#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :songs, only: %i[new create]
  resources :playlists do
    resources :playlist_songs, only: %i[new create]
    resources :buddies, only: %i[new create]
  end
  resources :playlist_songs, only: :delete
  resources :publications
  resources :subscriptions, only: %i[index new create delete]
  resources :users, only: %i[show]
end
