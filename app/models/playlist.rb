class Playlist < ApplicationRecord
  belongs_to :user
  has_many :buddies, dependent: :destroy
  has_many :playlist_songs, dependent: :destroy
  has_many :songs, through: :playlist_songs

  validates :name, presence: true

  def spotify_playlist
    @spotify_playlist ||= begin
      user = User.find(user_id).spotify_id
      RSpotify::Playlist.find(user, spotify_id)
    end
  end
end
