import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal", "form", "profile"];

  submit(event) {
    event.preventDefault()
    this.modalTarget.classList.add("hidden")    
  }

  open() {
    const modal = document.querySelector('[data-modal-target="modal"]')
    
    if (modal) {
      modal.classList.remove('hidden');
    }
  }

  close() {
    this.modalTarget.classList.add("hidden")
  }

  profile_open() {
    const modal = document.querySelector('[data-modal-target="profile"]')
    
    if (modal) {
      modal.classList.remove('hidden');
    }
  }

  profile_close() {
    this.profileTarget.classList.add("hidden")
  }


}
