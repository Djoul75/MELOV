class Publication < ApplicationRecord
  belongs_to :user
  after_create :build_track

  def track
    RSpotify::Track.find(spotify_url)
  end

  def build_track
    return unless spotify_url.present?

    @track = track
    self.cover_url = @track.album.images.first["url"]
    self.title = @track.name
    self.artist = @track.artists.first.name
    save
  end
end
