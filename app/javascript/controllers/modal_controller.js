import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal"]
  
  open() {
    const modal = document.querySelector('[data-modal-target="modal"]')
    
    if (modal) {
      modal.classList.remove('hidden');
    }
  }

  close() {
    this.modalTarget.classList.add("hidden")
  }
}
