class PlaylistSongsController < ApplicationController
  def create
    @playlist_song = PlaylistSong.new
    authorize @playlist_song
    spotify_track = RSpotify::Track.find(params[:track_id])
    artist = RSpotify::Artist.find(spotify_track.artists.first.id)

    song = Song.new(
      artist: artist.name,
      genres: artist.genres,
      length: spotify_track.duration_ms,
      title: spotify_track.name,
      spotify_track_id: spotify_track.id
    )
    song.save!
    playlist_song = PlaylistSong.new(playlist_id: params[:playlist_id], song_id: song.id)
    playlist_song.save!
    redirect_to playlist_path(params[:playlist_id])
  end
end
