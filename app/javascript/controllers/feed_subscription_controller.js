import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { feedId: Number }
  static targets = ["messages", "form"]

  // connect() {
  //   console.log(`Subscribe to the feed with the id ${this.feedIdValue}.`)
  //   this.channel = consumer.subscriptions.create(
  //     { channel: "FeedChannel", id: this.feedIdValue },
  //     // { received: data => this.messagesTarget.insertAdjacentHTML("afterbegin", data) },
  //     // { received: data => this.messagesTarget.#insertMessageScrollDownAndResetForm(data)},
  //   }

  //   disconnect() {
  //     console.log("Unsubscribed from the chatroom")
  //     this.channel.unsubscribe()
  //   }

    // #insertMessageScrollDownAndResetForm(data) {
    //   this.messagesTarget.insertAdjacentHTML("afterbegin", data)
    //   this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
    //   this.formTarget.reset()
    // }
  }
