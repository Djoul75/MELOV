class AddUrlToPublications < ActiveRecord::Migration[6.1]
  def change
    add_column :publications, :spotify_url, :string
  end
end
