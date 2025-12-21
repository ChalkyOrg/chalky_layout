import { Controller } from "@hotwired/stimulus"

const PORTAL_ID = "chalky-tooltip-portal"

export default class extends Controller {
  static targets = ["trigger", "tooltip", "arrow"]
  static values = {
    delay: { type: Number, default: 0 },
    position: { type: String, default: "auto" }
  }

  connect() {
    this.timeout = null
    this.originalParent = null
    this.originalNextSibling = null
    this.tooltipElement = null // Store reference when teleported
    this.arrowElement = null // Store arrow reference when teleported
    // Reset tooltip state on connect (fixes Turbo Drive cache issue)
    this.hideTooltip()
  }

  disconnect() {
    this.clearTimeout()
    // Ensure tooltip is returned to original position on disconnect
    this.returnTooltipToOriginalPosition()
  }

  getOrCreatePortal() {
    let portal = document.getElementById(PORTAL_ID)
    if (!portal) {
      portal = document.createElement("div")
      portal.id = PORTAL_ID
      portal.style.position = "fixed"
      portal.style.top = "0"
      portal.style.left = "0"
      portal.style.width = "0"
      portal.style.height = "0"
      portal.style.overflow = "visible"
      portal.style.zIndex = "9999"
      portal.style.pointerEvents = "none"
      document.body.appendChild(portal)
    }
    return portal
  }

  teleportToPortal() {
    const tooltip = this.tooltipTarget
    // Store references so we can access them when outside the controller's DOM
    this.tooltipElement = tooltip
    if (this.hasArrowTarget) {
      this.arrowElement = this.arrowTarget
    }
    // Save original position for later restoration
    this.originalParent = tooltip.parentNode
    this.originalNextSibling = tooltip.nextSibling

    const portal = this.getOrCreatePortal()
    portal.appendChild(tooltip)
  }

  returnTooltipToOriginalPosition() {
    if (this.originalParent && this.tooltipElement) {
      if (this.originalNextSibling) {
        this.originalParent.insertBefore(this.tooltipElement, this.originalNextSibling)
      } else {
        this.originalParent.appendChild(this.tooltipElement)
      }
      this.originalParent = null
      this.originalNextSibling = null
      this.tooltipElement = null
      this.arrowElement = null
    }
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

    // Teleport tooltip to portal (escapes backdrop-filter, overflow:hidden, etc.)
    this.teleportToPortal()

    // Position the tooltip using fixed positioning relative to viewport
    this.positionTooltip(tooltip, trigger)

    // Only toggle opacity/visibility - no scale (scale conflicts with transform positioning)
    tooltip.classList.remove("opacity-0", "invisible")
    tooltip.classList.add("opacity-100", "visible")
  }

  positionTooltip(tooltip, trigger) {
    const triggerRect = trigger.getBoundingClientRect()
    const gap = 8 // Space between trigger and tooltip

    // Reset styles before measuring
    tooltip.style.position = "fixed"
    tooltip.style.left = "0"
    tooltip.style.top = "0"
    tooltip.style.transform = ""
    tooltip.style.visibility = "hidden"

    // Force layout to get accurate tooltip dimensions
    const tooltipRect = tooltip.getBoundingClientRect()

    // Determine position: auto-calculate or use forced value
    const position = this.positionValue === "auto"
      ? this.calculateBestPosition(triggerRect, tooltipRect, gap)
      : this.positionValue

    // Reset for final positioning
    tooltip.style.left = ""
    tooltip.style.right = ""
    tooltip.style.top = ""
    tooltip.style.bottom = ""
    tooltip.style.transform = ""
    tooltip.style.visibility = ""

    // Apply position
    this.applyPosition(tooltip, triggerRect, position, gap)

    // Position the arrow
    if (this.arrowElement) {
      this.positionArrow(position)
    }
  }

  calculateBestPosition(triggerRect, tooltipRect, gap) {
    const viewport = {
      width: window.innerWidth,
      height: window.innerHeight
    }

    // Calculate available space in each direction
    const spaceAbove = triggerRect.top - gap
    const spaceBelow = viewport.height - triggerRect.bottom - gap
    const spaceLeft = triggerRect.left - gap
    const spaceRight = viewport.width - triggerRect.right - gap

    // Check if tooltip fits in each direction
    const fitsAbove = spaceAbove >= tooltipRect.height
    const fitsBelow = spaceBelow >= tooltipRect.height
    const fitsLeft = spaceLeft >= tooltipRect.width
    const fitsRight = spaceRight >= tooltipRect.width

    // Priority: top > bottom > right > left
    // Pick the first position where tooltip fits, or the one with most space
    if (fitsAbove) return "top"
    if (fitsBelow) return "bottom"
    if (fitsRight) return "right"
    if (fitsLeft) return "left"

    // Nothing fits perfectly, pick direction with most space
    const spaces = [
      { position: "top", space: spaceAbove },
      { position: "bottom", space: spaceBelow },
      { position: "right", space: spaceRight },
      { position: "left", space: spaceLeft }
    ]
    spaces.sort((a, b) => b.space - a.space)
    return spaces[0].position
  }

  applyPosition(tooltip, triggerRect, position, gap) {
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

  positionArrow(position) {
    const arrow = this.arrowElement
    // Reset arrow styles
    arrow.style.top = ""
    arrow.style.bottom = ""
    arrow.style.left = ""
    arrow.style.right = ""
    arrow.style.transform = ""

    // Note: must include rotate(45deg) to maintain the diamond shape
    // Position at -1px so the arrow is half inside the tooltip (hidden by z-index)
    switch (position) {
      case "bottom":
        // Arrow points up (at top of tooltip)
        arrow.style.top = "-1px"
        arrow.style.left = "50%"
        arrow.style.transform = "translateX(-50%) translateY(-50%) rotate(45deg)"
        break
      case "left":
        // Arrow points right (at right of tooltip)
        arrow.style.right = "-1px"
        arrow.style.top = "50%"
        arrow.style.transform = "translateX(50%) translateY(-50%) rotate(45deg)"
        break
      case "right":
        // Arrow points left (at left of tooltip)
        arrow.style.left = "-1px"
        arrow.style.top = "50%"
        arrow.style.transform = "translateX(-50%) translateY(-50%) rotate(45deg)"
        break
      default: // top
        // Arrow points down (at bottom of tooltip)
        arrow.style.bottom = "-1px"
        arrow.style.left = "50%"
        arrow.style.transform = "translateX(-50%) translateY(50%) rotate(45deg)"
        break
    }
  }

  hideTooltip() {
    // Use stored reference if tooltip is in portal, otherwise use Stimulus target
    const tooltip = this.tooltipElement || this.tooltipTarget
    tooltip.classList.remove("opacity-100", "visible")
    tooltip.classList.add("opacity-0", "invisible")

    // Return tooltip to original DOM position (so Stimulus can find it next time)
    this.returnTooltipToOriginalPosition()
  }

  clearTimeout() {
    if (this.timeout) {
      clearTimeout(this.timeout)
      this.timeout = null
    }
  }
}
