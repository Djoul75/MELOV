class AddImageUrlToPlaylist < ActiveRecord::Migration[6.1]
  def change
    add_column :playlists, :image_url, :string
  end
end
