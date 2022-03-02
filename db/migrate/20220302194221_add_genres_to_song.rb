class AddGenresToSong < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :genres, :text
    remove_column :songs, :genre
  end
end
