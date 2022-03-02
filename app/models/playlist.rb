class Playlist < ApplicationRecord
  belongs_to :user
  has_many :buddies
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs

  validates :name, presence: true, uniqueness: true
end
