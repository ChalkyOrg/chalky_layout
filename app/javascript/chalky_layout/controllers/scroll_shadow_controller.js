// Scroll Shadow Controller
// Adds visual shadow indicators for horizontal scroll containers
// Uses a wrapper/scroller structure so shadows stay fixed at container edges
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["scroller"]

  connect() {
    if (!this.hasScrollerTarget) return

    this.updateShadows()
    this.scrollerTarget.addEventListener("scroll", this.updateShadows.bind(this))

    // Also update on resize in case content changes
    this.resizeObserver = new ResizeObserver(() => this.updateShadows())
    this.resizeObserver.observe(this.scrollerTarget)
  }

  disconnect() {
    if (this.hasScrollerTarget) {
      this.scrollerTarget.removeEventListener("scroll", this.updateShadows.bind(this))
    }
    if (this.resizeObserver) {
      this.resizeObserver.disconnect()
    }
  }

  updateShadows() {
    if (!this.hasScrollerTarget) return

    const { scrollLeft, scrollWidth, clientWidth } = this.scrollerTarget
    const maxScroll = scrollWidth - clientWidth

    // Threshold for showing shadows (in pixels)
    const threshold = 5

    // Check if there's content to scroll
    const hasOverflow = scrollWidth > clientWidth

    // Determine which shadows to show
    const showLeftShadow = hasOverflow && scrollLeft > threshold
    const showRightShadow = hasOverflow && scrollLeft < (maxScroll - threshold)

    // Update classes on the wrapper (this.element), not the scroller
    this.element.classList.toggle("scroll-shadow-left", showLeftShadow)
    this.element.classList.toggle("scroll-shadow-right", showRightShadow)
  }
}
