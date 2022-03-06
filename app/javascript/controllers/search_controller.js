import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = ["spotifyurl", "trackid"]

  connect() {
    console.log(`coucou du search controller`)
  }

  songchoice(e) {
    // document.getElementById('publication_spotify_url').value = ''
    document.getElementById('publication_spotify_url').value = e.currentTarget.innerHTML.match(/>(.*)<\/p>/)[1];
    document.getElementById('query').value = e.currentTarget.innerText
  }

  initsearch() {
    window.history.pushState({}, document.title, "/" + "");
  }
}
