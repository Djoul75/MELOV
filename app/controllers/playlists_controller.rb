class PlaylistsController < ApplicationController
  def index
    @playlists = policy_scope(Playlist)
    @playlists = current_user.playlists
  end

  def show
    @playlist = Playlist.find(params[:id])
    authorize @playlist
  end

  def create
    user = RSpotify::User.find(current_user.spotify_id)
    user.playlists.first(5).each do |p|
      @playlist = Playlist.new(name: p.name, spotify_id: p.id, user_id: current_user.id)
      authorize @playlist
      @playlist.save ? playlist_id = @playlist.id : playlist_id = Playlist.find_by(name: @playlist.name).id

      p.tracks.first(20).each do |t|
        song = Song.find_by(title: t.name)
        artist = RSpotify::Artist.find(t.artists.first.id)

        if song
          song.update!(
            artist: artist.name,
            genres: artist.genres,
            length: t.duration_ms,
            title: t.name,
            spotify_track_id: t.id
          )
        else
          song = Song.create!(
            artist: artist.name,
            genres: artist.genres,
            length: t.duration_ms,
            title: t.name,
            spotify_track_id: t.id
          )
        end

        playlist_song = PlaylistSong.new(song_id: song.id, playlist_id: playlist_id)

        playlist_song.save
      end
    end

    redirect_to playlists_path
  end

  def add_a_user
    @user = User.new
    authorize @user
    @users = User.all
  end

  def shaker
    @playlist = Playlist.new
    authorize @playlist

    @songs_in_common = []
    current_user.playlists.each do |p|
      p.songs.each do |s|
        @songs_in_common << s.spotify_track_id
      end
    end

    @user = User.find(params[:format].to_i)
    @user.playlists.each do |p|
      p.songs.each do |s|
        @songs_in_common << s.spotify_track_id
      end
    end

    @songs_in_common.reject! do |s|
      @songs_in_common.count(s) == 1
    end

    @songs_in_common.uniq!
    date = Time.now.strftime("%d/%m/%y")

    if @songs_in_common.any?
      spotify_user = RSpotify::User.find(current_user.spotify_id)
      @playlist = spotify_user.create_playlist!("Shaker Playlist with #{@user.nickname} - #{date}") # et ajouter un id unique comme la date ?
      @tracks = @songs_in_common.map { |track| RSpotify::Track.find(track) }
      @playlist.add_tracks!(@tracks)
    end
  end
end
