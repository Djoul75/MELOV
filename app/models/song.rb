class Song < ApplicationRecord
  has_many :playlist_songs, dependent: :destroy
  has_many :playlists, through: :playlist_songs

  validates :artist, :title, presence: true
  validates :spotify_track_id, uniqueness: true
  serialize :genres, Array

  def spotify_track
    @spotify_track ||= RSpotify::Track.find(spotify_track_id)
  end
end
