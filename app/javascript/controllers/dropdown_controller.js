import { Controller } from "@hotwired/stimulus"

// Toggleable <details> dropdown that closes when a choice is made
// or when the user clicks outside of it.
export default class extends Controller {
  connect() {
    this.closeOnOutside = this.closeOnOutside.bind(this)
    document.addEventListener("click", this.closeOnOutside)
  }

  disconnect() {
    document.removeEventListener("click", this.closeOnOutside)
  }

  select() {
    this.element.removeAttribute("open")
  }

  closeOnOutside(event) {
    if (!this.element.contains(event.target)) {
      this.element.removeAttribute("open")
    }
  }
}
