import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon"]
  static values = {
    value: String
  }

  async copy() {
    if (!this.valueValue) return

    try {
      await navigator.clipboard.writeText(this.valueValue)
      this.showSuccess()
    } catch (err) {
      // Fallback for older browsers
      this.fallbackCopy()
    }
  }

  fallbackCopy() {
    const textArea = document.createElement("textarea")
    textArea.value = this.valueValue
    textArea.style.position = "fixed"
    textArea.style.left = "-9999px"
    document.body.appendChild(textArea)
    textArea.select()

    try {
      document.execCommand("copy")
      this.showSuccess()
    } catch (err) {
      console.error("Copy failed:", err)
    }

    document.body.removeChild(textArea)
  }

  showSuccess() {
    if (!this.hasIconTarget) return

    const icon = this.iconTarget
    const originalClasses = icon.className

    // Change to checkmark
    icon.className = "fa-solid fa-check text-xs text-chalky-success"

    // Revert after 2 seconds
    setTimeout(() => {
      icon.className = originalClasses
    }, 2000)
  }
}
