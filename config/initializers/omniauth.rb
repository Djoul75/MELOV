require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"], scope: 'user-read-email user-read-private streaming playlist-read-collaborative user-library-read user-library-modify user-read-currently-playing user-modify-playback-state user-read-playback-state playlist-modify-public playlist-modify-private playlist-read-private app-remote-control'
end
