import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { feedId: Number }
  static targets = ["messages", "form", "searchInput", "follow"]

  connect() {
    // console.log(`Subscribe to the feed with the id ${this.feedIdValue}.`)
    this.channel = consumer.subscriptions.create(
      { channel: "FeedChannel", id: this.feedIdValue },
      { received: data => this.#insertMessageScrollDownAndResetForm(data)},
    )
  }

  disconnect() {
    // console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }

  #insertMessageScrollDownAndResetForm(data) {
    this.followTarget.classList.add('d-none')
    this.messagesTarget.classList.remove('d-none')
    this.messagesTarget.insertAdjacentHTML("afterbegin", data)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  reset(){
    this.formTarget.reset()
    this.searchInputTarget.value = "";
  }
}
