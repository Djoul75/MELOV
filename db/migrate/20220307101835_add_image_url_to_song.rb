class AddImageUrlToSong < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :image_url, :string
  end
end
