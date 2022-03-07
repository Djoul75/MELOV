class PlaylistSongsController < ApplicationController
  def create
    @playlist_song = PlaylistSong.new
    authorize @playlist_song
    spotify_track = RSpotify::Track.find(params[:track_id])
    artist = RSpotify::Artist.find(spotify_track.artists.first.id)

    all_spotify_track_ids = []
    Song.all.each do |s|
      all_spotify_track_ids << s.spotify_track_id
    end

    if all_spotify_track_ids.include?(params[:track_id])
      song = Song.find_by(spotify_track_id:params[:track_id])
    else
      song = Song.new(
        artist: artist.name,
        genres: artist.genres,
        length: spotify_track.duration_ms,
        title: spotify_track.name,
        spotify_track_id: spotify_track.id
      )
      song.save!
    end

    playlist_song = PlaylistSong.new(playlist_id: params[:playlist_id], song_id: song.id)
    playlist_song.save!
    redirect_to playlist_path(params[:playlist_id])
  end
end
