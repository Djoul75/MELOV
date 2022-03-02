import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { feedId: Number }
  static targets = ["messages", "form"]

  connect() {
    console.log(`Subscribe to the feed with the id ${this.feedIdValue}.`)
    this.channel = consumer.subscriptions.create(
      { channel: "FeedChannel", id: this.feedIdValue },
      { received: data => this.#insertMessageScrollDownAndResetForm(data) },
      // { received: data => this.messagesTarget.insertAdjacentHTML("afterbegin", data) }

      // #insertMessageScrollDownAndResetForm(data) {
      //   this.messagesTarget.insertAdjacentHTML("beforeend", data)
      //   this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
      //   this.formTarget.reset()
      // }
    )
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }
}
