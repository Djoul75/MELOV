class PlaylistSongsController < ApplicationController
  def create
    song = Song.find_by(spotify_track_id: params[:track_id])
    @playlist_song = PlaylistSong.new
    authorize @playlist_song
    playlist_song = PlaylistSong.new(playlist_id: params[:playlist_id], song_id: song.id)
    playlist_song.save!
    redirect_to playlist_path(params[:playlist_id])
  end

  def destroy
    @playlist_song = PlaylistSong.find_by(playlist_id: params[:id], song_id: params[:song_id])
    authorize @playlist_song
    @playlist_song.destroy
    redirect_to playlist_path(params[:id])
  end
end
