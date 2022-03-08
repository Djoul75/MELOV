Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations' }
  root to: 'pages#home'
  get '/search', to: 'pages#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :songs, only: %i[new create]
  get '/adduser', to: 'playlists#add_a_user'
  get '/addingredient', to: 'playlists#add_a_ingredient'
  post '/shaker', to: 'playlists#shaker'
  get '/lookforuser', to: 'publications#look_for_user'
  post '/subscriptions_toggle', to: 'subscriptions#toggle'


  resources :playlists do
    get '/users', to: 'users#index'
    resources :playlist_songs, only: %i[new create]
    resources :buddies, only: %i[new create]
  end
  resources :playlist_songs, only: :destroy
  resources :publications
  resources :subscriptions, only: %i[index]

  resources :users, only: %i[show]
  resources :buddies, only: :create
end
