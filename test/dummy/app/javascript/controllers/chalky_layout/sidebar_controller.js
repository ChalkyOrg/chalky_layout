import { Controller } from "@hotwired/stimulus";

/**
 * Sidebar Controller
 *
 * Controls sidebar collapse/expand state with localStorage persistence.
 *
 * FOUC Prevention Strategy:
 * 1. Inline script in <head> adds 'sidebar-starts-collapsed' to <html> before render
 * 2. CSS uses this class to apply initial collapsed state WITHOUT transitions
 * 3. On connect(), we apply 'sidebar-collapsed' class to match visual state
 * 4. On first user interaction, we enable transitions via 'transitions-enabled' class
 *
 * Targets:
 * - sidebar: The aside element (.chalky-sidebar)
 * - content: The main content area (.chalky-main)
 * - toggleIcon: The chevron icon in the toggle button
 */
export default class extends Controller {
  static targets = ["sidebar", "content", "toggleIcon"]

  static values = {
    storageKey: { type: String, default: "chalky_sidebar_collapsed" }
  }

  connect() {
    this.transitionsEnabled = false
    this.applyInitialState()
  }

  applyInitialState() {
    const savedState = localStorage.getItem(this.storageKeyValue)
    const isCollapsed = savedState === "true"

    if (isCollapsed && this.hasSidebarTarget) {
      // Apply collapsed class immediately - CSS already has correct width from html class
      this.sidebarTarget.classList.add("sidebar-collapsed")
      this.updateToggleIcon(true)
    }
  }

  enableTransitions() {
    if (this.transitionsEnabled) return

    // Add transitions-enabled to body so CSS transitions activate
    document.body.classList.add("transitions-enabled")
    this.transitionsEnabled = true

    // Remove the initial state class from html since JS is now in control
    document.documentElement.classList.remove("sidebar-starts-collapsed")
  }

  toggle() {
    // Enable transitions on first user interaction
    this.enableTransitions()

    if (this.isCollapsed) {
      this.expand()
    } else {
      this.collapse()
    }
    this.saveState()
  }

  collapse() {
    if (!this.hasSidebarTarget) return

    this.sidebarTarget.classList.add("sidebar-collapsed")
    this.updateToggleIcon(true)
  }

  expand() {
    if (!this.hasSidebarTarget) return

    this.sidebarTarget.classList.remove("sidebar-collapsed")
    this.updateToggleIcon(false)
  }

  updateToggleIcon(collapsed) {
    if (this.hasToggleIconTarget) {
      this.toggleIconTarget.classList.toggle("fa-chevron-left", !collapsed)
      this.toggleIconTarget.classList.toggle("fa-chevron-right", collapsed)
    }
  }

  get isCollapsed() {
    if (this.hasSidebarTarget) {
      return this.sidebarTarget.classList.contains("sidebar-collapsed")
    }
    return false
  }

  saveState() {
    localStorage.setItem(this.storageKeyValue, this.isCollapsed ? "true" : "false")
  }
}
