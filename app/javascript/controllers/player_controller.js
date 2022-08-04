import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "play", "next", "progress", "previous", "playerSongName", "playerArtist", 'playerCoverImg', 'volume', 'seekbar', 'pause' ]
  static values = { token: String, songId: String }

  connect() {
    window.onSpotifyWebPlaybackSDKReady = () => {
      const token = this.tokenValue;
      this.player = new Spotify.Player({
          name: 'MELOV APP',
          getOAuthToken: cb => { cb(token); },
          volume: 1
      });
      if (window.localStorage.cover) {
        this.playerCoverImgTarget.src = window.localStorage.cover
        this.playerSongNameTarget.innerHTML = '<h2>' + window.localStorage.title + '</h2>'
        this.playerArtistTarget.innerText = window.localStorage.artist
      } else {
        this.playerCoverImgTarget.src = "https://i.scdn.co/image/ab67616d0000b27324e55312fa159bd1a9957aab"
        this.playerSongNameTarget.innerText = "En lea"
        this.playerArtistTarget.innerText = "Muddy Monk"
      }

      // Ready
      this.player.addListener('ready', ({ device_id }) => {
          console.log('Ready with Device ID', device_id);
          this.id = device_id
      });

      this.player.addListener('player_state_changed', (state) => {
        if (!state) return
        const {
          position,
          duration,
          paused,
          track_window: { current_track }
        } = state
        console.log('Currently Playing', current_track);
        console.log('Position in Song', position);
        console.log('Duration of Song', duration);

        window.localStorage.setItem("cover", current_track.album.images[0].url)
        window.localStorage.setItem("title", current_track.name)
        window.localStorage.setItem("artist", current_track.artists[0].name)
        window.localStorage.setItem("song", current_track.id)

        this.playerCoverImgTarget.src = current_track.album.images[0].url
        this.playerSongNameTarget.innerHTML = '<h2>' + current_track.name + '</h2>'
        this.playerArtistTarget.innerText = current_track.artists[0].name

        this.seekbarTarget.value = position
        this.seekbarTarget.max = duration
        this.progressTarget.style.width = (position / duration) * 100 + '%'

        clearInterval(this.seekInterval)

        if (!paused) {
          this.seekInterval = setInterval(() => {
            const value = parseInt(this.seekbarTarget.value) + 100
            this.seekbarTarget.value = value
            this.progressTarget.style.width = (value / duration) * 100 + '%'
            console.log(this.seekbarTarget.value);
          }, 100);
          this.playTarget.classList.add('d-none')
          this.pauseTarget.classList.remove('d-none')
        } else {
          this.pauseTarget.classList.add('d-none')
          this.playTarget.classList.remove('d-none')
        }

        this.player.getVolume().then(volume => {
          let volume_percentage = volume * 100;
          console.log(`The volume of the player is ${volume_percentage}%`);
        });
      });

      // Not Ready
      this.player.addListener('not_ready', ({ device_id }) => {
          console.log('Device ID has gone offline', device_id);
      });

      this.player.addListener('initialization_error', ({ message }) => {
          console.error(message);
      });

      this.player.addListener('authentication_error', ({ message }) => {
          console.error(message);
      });

      this.player.addListener('account_error', ({ message }) => {
          console.error(message);
      });

      this.player.connect();
    }
  }

  disconnect() {
    clearInterval(this.seekInterval)
  }

  previous() {
    this.player.previousTrack().then(() => {
      console.log('Set to previous track!');
    });
  }

  play() {
    if (this.uri) {
      this.player.togglePlay();
    } else {
      const track = window.localStorage.song || '4BNiO9JthDUkbNsKxLH9lg'
      this.setPlay(`spotify:track:${track}`);
    }
  }

  next() {
    this.player.nextTrack().then(() => {
      console.log('Skipped to next track!');
    });
  }

  changeVolume() {
    const newVolume = this.volumeTarget.value
    this.player.setVolume(newVolume).then(() => {
    console.log('Volume updated!');
    });
  };

  changeSeek() {
    const newSeek = this.seekbarTarget.value
    this.player.seek(newSeek).then(() => {
      console.log('Changed position!');
      this.progressTarget.style.width = (parseInt(this.seekbarTarget.value) / parseInt(this.seekbarTarget.max)) * 100 + '%'
    });
  }

  sendtrack(e) {
    this.setPlay(e.currentTarget.dataset.trackId);
  }
  sendplaylist(e) {
    this.setPlaylist(e.currentTarget.dataset.trackId, e.currentTarget.dataset.playlistId);
  }

  setPlay(uri) {
    this.uri = uri
    const play = ({
      spotify_uri,
      playerInstance: {
        _options: {
          getOAuthToken
        }
      }
    }) => {
      getOAuthToken(access_token => {
        fetch(`https://api.spotify.com/v1/me/player/play?device_id=${this.id}`, {
          method: 'PUT',
          body: JSON.stringify({ uris: [spotify_uri] }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${access_token}`
          },
        });
      });
    };

    play({
      playerInstance: this.player,
      spotify_uri: uri,
    });
  }

  setPlaylist(uri, playlist_uri) {
    this.uri = uri
    const play = ({
      spotify_uri,
      playerInstance: {
        _options: {
          getOAuthToken
        }
      }
    }) => {
      getOAuthToken(access_token => {
        fetch(`https://api.spotify.com/v1/me/player/play?device_id=${this.id}`, {
          method: 'PUT',
          body: JSON.stringify({ context_uri: playlist_uri }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${access_token}`
          },
        });
      });
    };

    play({
      playerInstance: this.player,
      spotify_uri: uri,
    });
  }

}
