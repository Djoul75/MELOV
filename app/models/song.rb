class Song < ApplicationRecord
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs

  validates :artist, :title, presence: true
  validates :title, uniqueness: { scope: :artist }
end
