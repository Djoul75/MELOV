class PlaylistsController < ApplicationController
  def index
    @playlists = policy_scope(Playlist)
    @playlists = current_user.playlists
    spotify_user = RSpotify::User.find(current_user.spotify_id)
    @spotify_playlist = spotify_user.playlists
  end

  def show
    @playlist = Playlist.find(params[:id])
    authorize @playlist
  end

  def create
    user = RSpotify::User.find(current_user.spotify_id)
    spotify_playlist = RSpotify::Playlist.find(user.id, params[:spotify_playlist_id])
    @playlist = Playlist.new(
      name: spotify_playlist.name,
      spotify_id: spotify_playlist.id,
      user_id: current_user.id,
      image_url: spotify_playlist.images.first["url"]
    )
    authorize @playlist
    @playlist.save!

    spotify_playlist.tracks.each do |t|
      song = Song.find_by(title: t.name)
      artist = RSpotify::Artist.find(t.artists.first.id)
      attributes = {
        artist: artist.name,
        genres: artist.genres,
        length: t.duration_ms,
        title: t.name,
        spotify_track_id: t.id,
        image_url: t.album.images.dig(0, "url")
      }
      if song
        song.update!(attributes)
      else
        song = Song.create!(attributes)
      end

      playlist_song = PlaylistSong.new(song_id: song.id, playlist_id: @playlist.id)

      playlist_song.save
    end

    redirect_to playlists_path
  end

  def add_a_user
    @user = User.new
    authorize @user
    @users = User.all
  end

  def shaker
    date = Time.now.strftime("%d/%m/%y")
    @user = User.find(params[:user_id].to_i)
    playlist_name = "Shaker Playlist with #{@user.nickname} - #{date}"

    @playlist = Playlist.new(user: current_user, shaker: true, name: playlist_name)
    authorize @playlist

    @songs_in_common = []

    current_user.playlists.each do |pl|
      pl.songs.each do |song|
        @songs_in_common << song.id
      end
    end

    @user.playlists.each do |pl|
      pl.songs.each do |song|
        @songs_in_common << song.id
      end
    end

    @songs_in_common.reject! do |song|
      @songs_in_common.count(song) == 1
    end

    @songs_in_common.uniq!


    if @songs_in_common.any?
      spotify_user = RSpotify::User.find(current_user.spotify_id)
      @spotify_playlist = spotify_user.create_playlist!(playlist_name)
      @playlist.spotify_id = @spotify_playlist.id
      @playlist.save!
      @songs_in_common.each do |song|
        PlaylistSong.create!(song_id: song, playlist_id: @playlist.id)
      end
      @tracks = @playlist.songs.map { |song| Song.find(song.id) }.compact
      tracks = @playlist.songs.map { |song| RSpotify::Track.find(song.spotify_track_id) }.compact
      @spotify_playlist.add_tracks!(tracks)
      @spotify_playlist = RSpotify::Playlist.find(spotify_user.id, @playlist.spotify_id)
      @playlist.image_url = @spotify_playlist.images.first["url"]
      @playlist.save!
    end
    @songs_in_common.clear
  end
end
