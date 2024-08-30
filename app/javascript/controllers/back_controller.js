import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="back"
export default class extends Controller {
  goBack(event) {
    // event.preventDefault();
    // window.history.back();
  }
}
