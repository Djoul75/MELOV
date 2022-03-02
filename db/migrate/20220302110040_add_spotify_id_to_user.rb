class AddSpotifyIdToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :spotify_id, :string
  end
end
