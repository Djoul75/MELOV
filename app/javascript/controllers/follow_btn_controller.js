// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "followBtn", "unfollowBtn" ]

  displayUnfollowBtn() {
    this.unfollowBtnTarget.classList.remove('d-none')
    this.followBtnTarget.classList.add('d-none')
  }

  displayFollowBtn() {
    this.unfollowBtnTarget.classList.add('d-none')
    this.followBtnTarget.classList.remove('d-none')
  }
}
