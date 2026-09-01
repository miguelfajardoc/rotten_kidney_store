import { Controller } from "@hotwired/stimulus"

// Product image gallery: clicking a thumbnail swaps the main image.
// Wrap the main <img> and the thumbnail buttons in data-controller="gallery".
export default class extends Controller {
  static targets = ["main", "thumb"]

  select(event) {
    const button = event.currentTarget
    this.mainTarget.src = button.dataset.galleryFullUrl
    this.thumbTargets.forEach((t) => t.classList.toggle("ring-2", t === button))
    this.thumbTargets.forEach((t) => t.classList.toggle("ring-sky-500", t === button))
  }
}
