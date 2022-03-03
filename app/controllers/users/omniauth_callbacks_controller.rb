class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def spotify
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # Now you can access user's private data, create playlists and much more
    @user = User.find_or_initialize_by(email: @spotify_user.email, spotify_id: @spotify_user.id)
    # Access private data
    @user.spotify_token = @spotify_user.id
    @user.token = @spotify_user.credentials["token"]

    if @user.new_record?
      @user.password = Devise.friendly_token
      redirection_url = edit_user_registration_path
    else
      redirection_url = root_path
    end
    @user.save
    sign_in @user

    redirect_to redirection_url
  end
end
