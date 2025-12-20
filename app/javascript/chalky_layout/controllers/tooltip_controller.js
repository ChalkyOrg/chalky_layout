import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["trigger", "tooltip"]
  static values = {
    delay: { type: Number, default: 0 }
  }

  connect() {
    this.timeout = null
    // Reset tooltip state on connect (fixes Turbo Drive cache issue)
    this.hideTooltip()
  }

  disconnect() {
    this.clearTimeout()
  }

  show() {
    this.clearTimeout()

    if (this.delayValue > 0) {
      this.timeout = setTimeout(() => this.displayTooltip(), this.delayValue)
    } else {
      this.displayTooltip()
    }
  }

  hide() {
    this.clearTimeout()
    this.hideTooltip()
  }

  displayTooltip() {
    const tooltip = this.tooltipTarget
    tooltip.classList.remove("opacity-0", "invisible", "scale-95")
    tooltip.classList.add("opacity-100", "visible", "scale-100")
  }

  hideTooltip() {
    const tooltip = this.tooltipTarget
    tooltip.classList.remove("opacity-100", "visible", "scale-100")
    tooltip.classList.add("opacity-0", "invisible", "scale-95")
  }

  clearTimeout() {
    if (this.timeout) {
      clearTimeout(this.timeout)
      this.timeout = null
    }
  }
}
