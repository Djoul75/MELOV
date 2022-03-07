class Publication < ApplicationRecord
  belongs_to :user
  after_create :build_track

  def track
    RSpotify::Track.find(spotify_url)
  end

  def build_track
    if Song.find_by(spotify_track_id: spotify_url)
      @track = Song.find_by(spotify_track_id: spotify_url)
    else
      @track = track

      Song.create!(
        artist: @track.artists.first.name,
        title: @track.name,
        length: @track.duration_ms,
        spotify_track_id: @track.id,
        image_url: @track.album.images.first["url"]
      )
    end
    self.cover_url = @track.image_url
    self.title = @track.title
    self.artist = @track.artist
    self.song_duration = @track.length
    save
  end
end
