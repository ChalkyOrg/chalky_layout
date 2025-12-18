import { Controller } from "@hotwired/stimulus";

// Controls mobile menu slide-in/out animations
// Connects to data-controller="chalky-mobile-menu"
export default class extends Controller {
  static targets = ["menu", "overlay"]

  connect() {
    // Ensure menu is hidden on connect
    this.close()
  }

  toggle() {
    if (this.hasMenuTarget && this.menuTarget.classList.contains("translate-x-full")) {
      this.open()
    } else {
      this.close()
    }
  }

  open() {
    if (this.hasOverlayTarget) {
      // Show overlay
      this.overlayTarget.classList.remove("hidden")
    }

    if (this.hasMenuTarget) {
      // Slide in menu
      setTimeout(() => {
        this.menuTarget.classList.remove("translate-x-full")
        this.menuTarget.classList.add("translate-x-0")
      }, 10)
    }

    // Prevent body scroll
    document.body.style.overflow = "hidden"
  }

  close() {
    if (this.hasMenuTarget) {
      // Slide out menu
      this.menuTarget.classList.remove("translate-x-0")
      this.menuTarget.classList.add("translate-x-full")
    }

    if (this.hasOverlayTarget) {
      // Hide overlay after animation
      setTimeout(() => {
        this.overlayTarget.classList.add("hidden")
      }, 300)
    }

    // Re-enable body scroll
    document.body.style.overflow = ""
  }

  disconnect() {
    // Clean up when controller is disconnected
    document.body.style.overflow = ""
  }
}
