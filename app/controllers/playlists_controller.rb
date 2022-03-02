class PlaylistsController < ApplicationController
  def create
    user = RSpotify::User.find(current_user.spotify_id)
    user.playlists.each do |p|
      @playlist = Playlist.new(name: p.name, spotify_id: p.id, user_id: current_user.id)
      authorize @playlist
      @playlist.save

      p.tracks.each do |t|
        song = Song.new(
          artist: t.artists.first.name,
          genre: t.album.genres.first,
          length: t.duration_ms,
          title: t.name
        )
        song.save

        playlist_song = PlaylistSong.new(song_id: song.id, playlist_id: @playlist.id)

        playlist_song.save
      end
    end
  end
end
