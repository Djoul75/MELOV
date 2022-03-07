import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = ["listplaylist", "loader"]

  connect() {
    console.log(`coucou du import controller`)
  }

  loading() {
    console.log('loading');
    this.listplaylistTarget.classList.add('d-none')
    this.loaderTarget.classList.remove('d-none')
  }
}
