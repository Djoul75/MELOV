import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { feedId: Number }
  static targets = ["messages", "form"]

  connect() {
    this.channel = consumer.subscriptions.create(
    { channel: "FeedChannel", id: this.feedIdValue },
    { received: data => console.log(data) }
    )
    console.log(`Subscribe to the feed with the id ${this.feedIdValue}.`)
  }
}
