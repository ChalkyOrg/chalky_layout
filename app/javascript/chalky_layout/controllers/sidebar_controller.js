import { Controller } from "@hotwired/stimulus";

// Controls sidebar collapse/expand state with localStorage persistence
// Connects to data-controller="chalky-sidebar"
export default class extends Controller {
  static targets = ["sidebar", "content", "toggleIcon", "logo"]
  static classes = ["collapsed"]

  static values = {
    storageKey: { type: String, default: "chalky_sidebar_collapsed" }
  }

  connect() {
    this.loadState()
  }

  toggle() {
    if (this.isCollapsed) {
      this.expand()
    } else {
      this.collapse()
    }
    this.saveState()
  }

  collapse() {
    if (this.hasSidebarTarget) {
      this.sidebarTarget.classList.add("sidebar-collapsed")
      this.sidebarTarget.classList.remove("lg:w-80")
      this.sidebarTarget.classList.add("lg:w-20")
    }

    if (this.hasContentTarget) {
      this.contentTarget.classList.remove("lg:ml-80")
      this.contentTarget.classList.add("lg:ml-20")
    }

    this.updateToggleIcon(true)
    this.updateLogo(true)
  }

  expand() {
    if (this.hasSidebarTarget) {
      this.sidebarTarget.classList.remove("sidebar-collapsed")
      this.sidebarTarget.classList.remove("lg:w-20")
      this.sidebarTarget.classList.add("lg:w-80")
    }

    if (this.hasContentTarget) {
      this.contentTarget.classList.remove("lg:ml-20")
      this.contentTarget.classList.add("lg:ml-80")
    }

    this.updateToggleIcon(false)
    this.updateLogo(false)
  }

  updateToggleIcon(collapsed) {
    if (this.hasToggleIconTarget) {
      this.toggleIconTarget.classList.toggle("fa-chevron-left", !collapsed)
      this.toggleIconTarget.classList.toggle("fa-chevron-right", collapsed)
    }
  }

  updateLogo(collapsed) {
    if (this.hasLogoTarget) {
      this.logoTarget.classList.toggle("hidden", collapsed)
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

  loadState() {
    const savedState = localStorage.getItem(this.storageKeyValue)
    if (savedState === "true") {
      this.collapse()
    }
  }
}
