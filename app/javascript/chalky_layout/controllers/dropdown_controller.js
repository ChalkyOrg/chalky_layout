import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu", "content", "trigger"]

  // Class-level property to track all open dropdowns
  static openDropdowns = new Set()

  // Constants for repositioning logic
  static VIEWPORT_MARGIN = 20
  static MIN_DROPDOWN_HEIGHT = 120 // Minimum expected dropdown height

  connect() {
    // Bind the outside click handler to maintain 'this' context
    this.boundOutsideClickHandler = this.handleOutsideClick.bind(this)

    // Bind modal opening handler to maintain 'this' context
    this.boundModalOpeningHandler = this.handleModalOpening.bind(this)

    // Listen for modal opening events
    document.addEventListener('modal:opening', this.boundModalOpeningHandler)

    // Add this instance to the tracking set
    this.constructor.openDropdowns.add(this)
  }

  disconnect() {
    // Clean up event listeners when controller disconnects
    document.removeEventListener("click", this.boundOutsideClickHandler)
    document.removeEventListener('modal:opening', this.boundModalOpeningHandler)

    // Remove this instance from tracking set
    this.constructor.openDropdowns.delete(this)

    // Reset any positioning if needed
    this.resetDropdownPosition()
  }

  toggle(event) {
    // Prevent event bubbling to avoid conflicts
    if (event) {
      event.stopPropagation()
    }

    const target = this.getDropdownTarget()
    if (!target) {
      return
    }
    if (target.classList.contains("hidden")) {
      this.show()
    } else {
      this.hide()
    }
  }

  show() {
    // First, close any other open dropdowns
    this.closeOthers()

    const target = this.getDropdownTarget()
    if (!target) return

    // Remove hidden class to show dropdown
    target.classList.remove("hidden")

    // Apply fixed positioning to escape overflow containers
    this.applyFixedPositioning()

    // If this dropdown is in a list (sidebar), elevate its parent card
    const venueItem = this.element.closest('.venue-item')
    if (venueItem) {
      venueItem.style.zIndex = '10001'
    }

    // Add outside click listener only when dropdown is open
    setTimeout(() => {
      document.addEventListener("click", this.boundOutsideClickHandler)
    }, 10)

    // Add scroll listener for repositioning
    this.scrollableParent = this.findScrollableParent()
    if (this.scrollableParent) {
      this.boundScrollHandler = this.handleScroll.bind(this)
      this.scrollableParent.addEventListener('scroll', this.boundScrollHandler)
    }

    // Add window resize listener
    this.boundResizeHandler = this.handleResize.bind(this)
    window.addEventListener('resize', this.boundResizeHandler)
  }

  hide() {
    const target = this.getDropdownTarget()
    if (!target) return

    target.classList.add("hidden")

    // Reset positioning
    this.resetDropdownPosition()

    // Reset the z-index of the parent card
    const venueItem = this.element.closest('.venue-item')
    if (venueItem) {
      venueItem.style.zIndex = ''
    }

    // Remove event listeners
    document.removeEventListener("click", this.boundOutsideClickHandler)

    if (this.scrollableParent && this.boundScrollHandler) {
      this.scrollableParent.removeEventListener('scroll', this.boundScrollHandler)
    }

    if (this.boundResizeHandler) {
      window.removeEventListener('resize', this.boundResizeHandler)
    }
  }

  handleOutsideClick(event) {
    // Check if click is outside the dropdown element
    if (!this.element.contains(event.target)) {
      this.hide()
    }
  }

  handleScroll() {
    // Reposition on scroll
    if (this.isOpen) {
      this.applyFixedPositioning()
    }
  }

  handleResize() {
    // Reposition on resize
    if (this.isOpen) {
      this.applyFixedPositioning()
    }
  }

  applyFixedPositioning() {
    const menu = this.getDropdownTarget()
    const trigger = this.element.querySelector('button') || this.element.querySelector('[data-action*="dropdown#toggle"]')

    if (!menu || !trigger) return

    // Store original styles if not already stored
    if (!this.originalStyles) {
      this.originalStyles = {
        position: menu.style.position || '',
        top: menu.style.top || '',
        left: menu.style.left || '',
        right: menu.style.right || '',
        bottom: menu.style.bottom || '',
        transform: menu.style.transform || '',
        zIndex: menu.style.zIndex || ''
      }
    }

    // Get trigger position relative to viewport
    const triggerRect = trigger.getBoundingClientRect()
    const viewportWidth = window.innerWidth
    const viewportHeight = window.innerHeight

    // Apply fixed positioning to escape overflow containers
    menu.style.position = 'fixed'
    menu.style.zIndex = '10002'

    // Calculate dropdown dimensions
    const menuRect = menu.getBoundingClientRect()
    const menuWidth = menuRect.width || 288 // max-w-72 = 288px
    const menuHeight = menuRect.height || this.constructor.MIN_DROPDOWN_HEIGHT

    // Default position: below and aligned with trigger left
    let top = triggerRect.bottom + 8
    let left = triggerRect.left

    // Adjust horizontal position if it would overflow viewport
    if (left + menuWidth > viewportWidth - this.constructor.VIEWPORT_MARGIN) {
      left = triggerRect.right - menuWidth

      if (left < this.constructor.VIEWPORT_MARGIN) {
        left = viewportWidth - menuWidth - this.constructor.VIEWPORT_MARGIN
      }
    }

    // Ensure minimum left margin
    if (left < this.constructor.VIEWPORT_MARGIN) {
      left = this.constructor.VIEWPORT_MARGIN
    }

    // Check vertical space and position above if needed
    const spaceBelow = viewportHeight - triggerRect.bottom
    const spaceAbove = triggerRect.top

    if (spaceBelow < menuHeight + this.constructor.VIEWPORT_MARGIN &&
        spaceAbove > spaceBelow) {
      top = triggerRect.top - menuHeight - 8
    }

    // Ensure dropdown stays within viewport
    if (top < this.constructor.VIEWPORT_MARGIN) {
      top = this.constructor.VIEWPORT_MARGIN
    }
    if (top + menuHeight > viewportHeight - this.constructor.VIEWPORT_MARGIN) {
      top = this.constructor.VIEWPORT_MARGIN
      menu.style.maxHeight = `${viewportHeight - 2 * this.constructor.VIEWPORT_MARGIN}px`
      menu.style.overflowY = 'auto'
    }

    // Apply calculated position
    menu.style.top = `${top}px`
    menu.style.left = `${left}px`
    menu.style.right = 'auto'
    menu.style.bottom = 'auto'
    menu.style.transform = 'none'
  }

  resetDropdownPosition() {
    const menu = this.getDropdownTarget()
    if (!menu) return

    // Reset to original styles
    if (this.originalStyles) {
      menu.style.position = this.originalStyles.position
      menu.style.top = this.originalStyles.top
      menu.style.left = this.originalStyles.left
      menu.style.right = this.originalStyles.right
      menu.style.bottom = this.originalStyles.bottom
      menu.style.transform = this.originalStyles.transform
      menu.style.zIndex = this.originalStyles.zIndex
      menu.style.maxHeight = ''
      menu.style.overflowY = ''

      this.originalStyles = null
    }
  }

  findScrollableParent() {
    let parent = this.element.parentElement

    while (parent && parent !== document.body) {
      const style = window.getComputedStyle(parent)
      const overflow = style.overflow + style.overflowX + style.overflowY

      if (overflow.includes('auto') || overflow.includes('scroll')) {
        return parent
      }

      parent = parent.parentElement
    }

    return window
  }

  // Close all other dropdowns except this one
  closeOthers() {
    this.constructor.openDropdowns.forEach(dropdown => {
      if (dropdown !== this && dropdown.isOpen) {
        dropdown.hide()
      }
    })
  }

  // Check if this dropdown is currently open
  get isOpen() {
    const target = this.getDropdownTarget()
    return target && !target.classList.contains("hidden")
  }

  // Get the dropdown target (menu or content)
  getDropdownTarget() {
    if (this.hasMenuTarget) {
      return this.menuTarget
    } else if (this.hasContentTarget) {
      return this.contentTarget
    }
    return null
  }

  // Handle modal opening event
  handleModalOpening(event) {
    if (this.isOpen) {
      this.hide()
    }
  }

  // Public method to force repositioning (useful for external calls)
  forceReposition() {
    if (this.isOpen) {
      this.applyFixedPositioning()
    }
  }
}
