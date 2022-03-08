import { csrfToken } from "@rails/ujs"
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "btn", "count" ]
  static values = { userId: String }

  async toggle(evt) {
    const options = {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
    }

    const response = await fetch(`/subscriptions_toggle?user_id=${this.userIdValue}`, options)
    const data = await response.json();

    if (data.status === 'created') {
      this.btnTarget.classList.add('following')
      this.btnTarget.innerText = 'Unsubscribe'
    } else {
      this.btnTarget.classList.remove('following')
      this.btnTarget.innerText = 'Subscribe'
    }

    this.countTarget.innerText = data.count
  }
}



// import { Controller } from "stimulus"

// export default class extends Controller {
//   static targets = [ "followBtn", "unfollowBtn", "count" ]

//   displayUnfollowBtn() {
//     this.unfollowBtnTarget.classList.remove('d-none')
//     this.followBtnTarget.classList.add('d-none')
//   }

//   displayFollowBtn(evt) {
//     this.unfollowBtnTarget.classList.add('d-none')
//     this.followBtnTarget.classList.remove('d-none')
//   }
// }

// au click -> fetch create
// Controller retourne la partial
// JS fetch & insere dans la page
// Stimulus cours
