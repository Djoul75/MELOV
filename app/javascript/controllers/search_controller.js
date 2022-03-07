import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = ["trackid", "form", "list", "searchInput"]

  connect() {
    // console.log(`coucou du search controller`)
  }

  songchoice(e) {
    // document.getElementById('publication_spotify_url').value = ''
    document.getElementById('publication_spotify_url').value = e.currentTarget.dataset.spotifyId;
    document.getElementById('query').value = e.currentTarget.innerText;
    this.listTarget.innerHTML = "";
  }

  initsearch() {
    window.history.pushState({}, document.title, "/" + "");
  }

  update() {
    const url = `${this.formTarget.action}?query=${this.searchInputTarget.value}`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.innerHTML = data;
      })
  }
}
