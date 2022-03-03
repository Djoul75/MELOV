class AddTrackInfosToPublication < ActiveRecord::Migration[6.1]
  def change
    add_column :publications, :cover_url, :string
    add_column :publications, :title, :string
    add_column :publications, :artist, :string
  end
end
