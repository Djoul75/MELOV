import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["heart"]

  connect() {
    console.log(this.heartTarget)
  }
}
