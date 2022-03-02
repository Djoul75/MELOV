class PlaylistsController < ApplicationController
  def create
    user = RSpotify::User.find(current_user.spotify_id)
    user.playlists.first(5).each do |p|
      @playlist = Playlist.new(name: p.name, spotify_id: p.id, user_id: current_user.id)
      authorize @playlist
      @playlist.save ? playlist_id = @playlist.id : playlist_id = Playlist.find_by(name: @playlist.name).id

      p.tracks.each do |t|
        song = Song.new(
          artist: t.artists.first.name,
          genre: t.album.genres.first,
          length: t.duration_ms,
          title: t.name
        )
        song.save ? song_id = song.id : song_id = Song.find_by(title: song.title)

        playlist_song = PlaylistSong.new(song_id: song_id, playlist_id: playlist_id)

        playlist_song.save
      end
    end
  end
end
