class Publication < ApplicationRecord
  belongs_to :user
  after_create :build_track

  def track
    RSpotify::Track.find(spotify_url)
  end

  def build_track
    return unless spotify_url.present?
    @track = track

    Song.create!(
      artist: @track.artists.first.name,
      title: @track.name,
      length: @track.duration_ms,
      spotify_track_id: @track.id,
      image_url: @track.album.images.first["url"]
    )

    self.cover_url = @track.album.images.first["url"]
    self.title = @track.name
    self.artist = @track.artists.first.name
    self.song_duration = @track.duration_ms
    save
  end
end
