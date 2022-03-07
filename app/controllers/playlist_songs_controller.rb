class PlaylistSongsController < ApplicationController
  def create
    song = Song.find_by(spotify_track_id: params[:track_id])
    @playlist_song = PlaylistSong.new
    authorize @playlist_song
    playlist_song = PlaylistSong.new(playlist_id: params[:playlist_id], song_id: song.id)
    playlist_song.save!
    redirect_to playlist_path(params[:playlist_id])
  end
end
