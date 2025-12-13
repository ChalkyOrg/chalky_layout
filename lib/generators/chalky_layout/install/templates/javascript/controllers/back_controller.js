import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    fallbackUrl: { type: String, default: "/" }
  }

  goBack(event) {
    event.preventDefault()
    if (window.history.length > 1) {
      window.history.back()
    } else {
      window.location.href = this.fallbackUrlValue
    }
  }
}
