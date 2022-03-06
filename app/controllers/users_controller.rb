class UsersController < ApplicationController
  def index
    @users = policy_scope(User)
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def spotify_playlist
    @spotify_playlist ||= begin
      user = User.find(user_id).spotify_id
      RSpotify::Playlist.find(user, spotify_id)
    end
  end
end
