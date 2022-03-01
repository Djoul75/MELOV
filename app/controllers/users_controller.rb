class UsersController < ApplicationController
  # def authentification
  #   @user = User.new
  #   authorize @user
  # end

  def spotify
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # Now you can access user's private data, create playlists and much more
    authorize @spotify_user
    @spotify_user.country
  end
end
