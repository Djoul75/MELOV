class AddSpotifyIdToPlaylist < ActiveRecord::Migration[6.1]
  def change
    add_column :playlists, :spotify_id, :string
  end
end
