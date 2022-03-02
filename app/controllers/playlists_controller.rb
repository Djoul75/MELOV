class PlaylistsController < ApplicationController
  def index
    @playlists = policy_scope(Playlist)
    @user = User.find(current_user.id)
    @playlists = Playlist.where(user_id: @user)
  end

  def create
    user = RSpotify::User.find(current_user.spotify_id)
    user.playlists.first(5).each do |p|
      @playlist = Playlist.new(name: p.name, spotify_id: p.id, user_id: current_user.id)
      authorize @playlist
      @playlist.save ? playlist_id = @playlist.id : playlist_id = Playlist.find_by(name: @playlist.name).id

      p.tracks.each do |t|
        song = Song.find_by(title: t.name)
        artist = RSpotify::Artist.find(t.artists.first.id)

        if song
          song.update!(
            artist: artist.name,
            genres: artist.genres,
            length: t.duration_ms,
            title: t.name
          )
        else
          song = Song.create!(
            artist: artist.name,
            genres: artist.genres,
            length: t.duration_ms,
            title: t.name
          )
        end

        playlist_song = PlaylistSong.new(song_id: song.id, playlist_id: playlist_id)

        playlist_song.save
      end
    end

    redirect_to playlists_path
  end
end
