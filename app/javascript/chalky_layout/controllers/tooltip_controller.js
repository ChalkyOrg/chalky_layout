import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["trigger", "tooltip"]
  static values = {
    delay: { type: Number, default: 0 },
    position: { type: String, default: "top" }
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
    const trigger = this.triggerTarget

    // Position the tooltip using fixed positioning to escape overflow:hidden containers
    this.positionTooltip(tooltip, trigger)

    tooltip.classList.remove("opacity-0", "invisible", "scale-95")
    tooltip.classList.add("opacity-100", "visible", "scale-100")
  }

  positionTooltip(tooltip, trigger) {
    const triggerRect = trigger.getBoundingClientRect()
    const tooltipRect = tooltip.getBoundingClientRect()
    const position = this.positionValue

    // Use fixed positioning
    tooltip.style.position = "fixed"
    tooltip.style.left = ""
    tooltip.style.right = ""
    tooltip.style.top = ""
    tooltip.style.bottom = ""
    tooltip.style.transform = ""

    const gap = 8 // Space between trigger and tooltip

    switch (position) {
      case "bottom":
        tooltip.style.top = `${triggerRect.bottom + gap}px`
        tooltip.style.left = `${triggerRect.left + triggerRect.width / 2}px`
        tooltip.style.transform = "translateX(-50%)"
        break
      case "left":
        tooltip.style.top = `${triggerRect.top + triggerRect.height / 2}px`
        tooltip.style.left = `${triggerRect.left - gap}px`
        tooltip.style.transform = "translate(-100%, -50%)"
        break
      case "right":
        tooltip.style.top = `${triggerRect.top + triggerRect.height / 2}px`
        tooltip.style.left = `${triggerRect.right + gap}px`
        tooltip.style.transform = "translateY(-50%)"
        break
      default: // top
        tooltip.style.top = `${triggerRect.top - gap}px`
        tooltip.style.left = `${triggerRect.left + triggerRect.width / 2}px`
        tooltip.style.transform = "translate(-50%, -100%)"
        break
    }
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
