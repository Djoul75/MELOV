Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
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
