class Playlist < ApplicationRecord
  belongs_to :user
  has_many :publications
  has_many :buddies
  has_many :songs, through: :playlist_songs

  validates :name, presence: true
end
