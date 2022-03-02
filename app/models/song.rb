class Song < ApplicationRecord
  has_many :playlist_songs, dependent: :destroy
  has_many :playlists, through: :playlist_songs

  validates :artist, :title, presence: true
  validates :title, uniqueness: { scope: :artist }
  serialize :genres, Array
end
