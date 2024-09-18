import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hashtag"
export default class extends Controller {
  static values = { url: String }

  handleClick() {
    if (this.urlValue) {
      Turbo.visit(this.urlValue)
    } else {
      console.error("No URL provided")
    }
  }
}
