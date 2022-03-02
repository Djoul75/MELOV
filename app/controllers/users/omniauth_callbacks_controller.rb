class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def spotify
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # Now you can access user's private data, create playlists and much more
    @user = User.find_or_initialize_by(email: @spotify_user.email)
    # Access private data
    @user.spotify_token = @spotify_user.id
    @user.token = @spotify_user.credentials["token"]
    @user.save

    if @user.new_record?
      @user.password = Devise.friendly_token
      @user.save
    end
    sign_in @user

    redirect_to root_path
  end
end
