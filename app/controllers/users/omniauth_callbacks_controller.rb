class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def spotify
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'].merge({
                                                                            "credentials" => {
                                                                              "access_refresh_callback" => callback_proc
                                                                            }
                                                                          }))
    # Now you can access user's private data, create playlists and much more
    @user = User.find_or_initialize_by(email: @spotify_user.email, spotify_id: @spotify_user.id)
    # Access private data
    @user.spotify_token = @spotify_user.id
    @user.token = @spotify_user.credentials["token"]

    if @user.new_record?
      @user.password = Devise.friendly_token
    end
    @user.save
    sign_in @user

    redirect_to root_path
  end

  def callback_proc
    proc { |new_access_token, token_lifetime|
      self.save_new_access_token(new_access_token)
    }
  end

  # def refresh_token
  #   # callback_proc = Proc.new { |new_access_token, token_lifetime |
  #   #   self.save_new_access_token(new_access_token)
  #   # }

  #   spotify_user = RSpotify::User.new({
  #                                       'credentials' => {
  #                                         "token" => self.credentials["access_token"],
  #                                         "refresh_token" => self.credentials["refresh_token"],
  #                                         "access_refresh_callback" => callback_proc
  #                                       },
  #                                       'id' => self.credentials["user_id"]
  #                                     })
  #   #  RSpotify provides a way to facilitate persistence:
  #   hash = spotify_user.to_hash
  #   # hash containing all user attributes, including access tokens
  #   # Use the hash to persist the data the way you prefer...
  #   # Then recover the Spotify user whenever you like
  #   # spotify_user = RSpotify::User.new(hash)
  #   # spotify_user.create_playlist!('my_awesome_playlist') # automatically refreshes token
  # end
end
