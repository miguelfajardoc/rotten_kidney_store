import { Controller } from "@hotwired/stimulus"

// Toggles a confirmation modal. Wrap the trigger button and the dialog markup
// in an element with data-controller="modal".
export default class extends Controller {
  static targets = ["dialog"]

  open() {
    this.dialogTarget.classList.remove("hidden")
    document.addEventListener("keydown", this.onKeydown)
  }

  close() {
    this.dialogTarget.classList.add("hidden")
    document.removeEventListener("keydown", this.onKeydown)
  }

  // Close when the backdrop (but not the panel) is clicked.
  closeBackground(event) {
    if (event.target === this.dialogTarget) this.close()
  }

  onKeydown = (event) => {
    if (event.key === "Escape") this.close()
  }

  disconnect() {
    document.removeEventListener("keydown", this.onKeydown)
  }
}
