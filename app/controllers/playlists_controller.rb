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
    date = Time.now.strftime("%d/%m/%y")
    @user = User.find(params[:format].to_i)
    playlist_name = "Shaker Playlist with #{@user.nickname} - #{date}"

    playlist = Playlist.new(user: current_user, shaker: true, name: playlist_name)
    authorize playlist
    playlist.save!

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

    @songs_in_common.each do |song|
        PlaylistSong.create!(song_id: song, playlist_id: playlist.id)
      end

    if @songs_in_common.any?
      spotify_user = RSpotify::User.find(current_user.spotify_id)
      @spotify_playlist = spotify_user.create_playlist!(playlist_name)
      playlist.spotify_id = @spotify_playlist.id
      playlist.save!
      @tracks = playlist.songs.map { |song| RSpotify::Track.find(song.spotify_track_id) }.compact
      @spotify_playlist.add_tracks!(@tracks)
    end
  end
end
