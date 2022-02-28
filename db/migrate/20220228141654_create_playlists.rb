class CreatePlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :playlists do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :shaker, default: false
      t.string :name

      t.timestamps
    end
  end
end
