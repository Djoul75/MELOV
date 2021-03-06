class Publication < ApplicationRecord
  belongs_to :user
  after_create :build_track
  has_many :likes, dependent: :destroy

  def track
    RSpotify::Track.find(spotify_url)
  end

  def build_track
    if Song.find_by(spotify_track_id: spotify_url)
      @track = Song.find_by(spotify_track_id: spotify_url)
      self.cover_url = @track.image_url
      self.title = @track.title
      self.artist = @track.artist
      self.song_duration = @track.length
    else
      @track = track
      artist = RSpotify::Artist.find(@track.artists.first.id)
      Song.create!(
        artist: @track.artists.first.name,
        title: @track.name,
        length: @track.duration_ms,
        spotify_track_id: @track.id,
        image_url: @track.album.images.dig(0, "url"),
        genres: artist.genres
        )
        self.cover_url = @track.album.images.first["url"]
        self.title = @track.name
        self.artist = @track.artists.first.name
        self.song_duration = @track.duration_ms
    end
    save
  end

  def like_for(user)
    likes.find_by(user_id: user.id)
  end
end
