class Playlist < ApplicationRecord
  belongs_to :user
  has_many :buddies, dependent: :destroy
  has_many :playlist_songs, dependent: :destroy
  has_many :songs, through: :playlist_songs

  validates :name, presence: true

  def artist_names
    artists = songs.map { |song| song.artist}.uniq
    if artists.size > 1
      "#{artists.first(3).join(', ')}..."
    else
      artists.first
    end
  end
end
