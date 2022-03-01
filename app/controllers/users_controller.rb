class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def authentication

    skip_authorization
    redirect_to "#{ENV['SPOTIFY_AUTH_URL']}?client_id=#{ENV['SPOTIFY_CLIENT_ID']}&redirect_uri=#{Rails.env.production? ? ENV['SPOTIFY_AUTH_CALLBACK_PROD'] : ENV['SPOTIFY_AUTH_CALLBACK_DEV']}&scope=user-read-private%20user-read-email&response_type=token&state=123"
  end

  def spotify
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # Now you can access user's private data, create playlists and much more
    authorize @spotify_user
    @spotify_user.email
    raise
  end
end
