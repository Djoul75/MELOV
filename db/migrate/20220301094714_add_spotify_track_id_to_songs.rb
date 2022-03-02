class AddSpotifyTrackIdToSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :spotify_track_id, :string
  end
end
