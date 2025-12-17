import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel"]
  static classes = ["active"]
  static values = {
    activeClass: { type: String, default: "active" }
  }

  connect() {
    // Apply initial active styles
    this.updateActiveStyles()
  }

  switch(event) {
    event.preventDefault()

    const clickedTab = event.currentTarget
    const tabId = clickedTab.dataset.tabId

    // Update all tabs
    this.tabTargets.forEach(tab => {
      const isActive = tab.dataset.tabId === tabId
      this.setTabActive(tab, isActive)
    })

    // Update panels if they exist
    if (this.hasPanelTarget) {
      this.panelTargets.forEach(panel => {
        panel.hidden = panel.id !== tabId
      })
    }

    // Dispatch custom event for external listeners
    this.dispatch("changed", { detail: { tabId } })
  }

  setTabActive(tab, isActive) {
    // Toggle visual classes
    const activeClasses = [
      "bg-light", "rounded-t-lg", "text-gray-900",
      "border-t", "border-l", "border-r", "border-gray-200",
      "-mb-px", "relative", "z-10"
    ]
    const inactiveClasses = [
      "text-gray-600", "hover:text-gray-900", "hover:bg-gray-50", "rounded-t-lg"
    ]

    if (isActive) {
      tab.classList.remove(...inactiveClasses)
      tab.classList.add(...activeClasses)
    } else {
      tab.classList.remove(...activeClasses)
      tab.classList.add(...inactiveClasses)
    }
  }

  updateActiveStyles() {
    // Find the initially active tab (one with active classes already applied)
    this.tabTargets.forEach(tab => {
      const isActive = tab.classList.contains("bg-light")
      if (isActive && this.hasPanelTarget) {
        const tabId = tab.dataset.tabId
        this.panelTargets.forEach(panel => {
          panel.hidden = panel.id !== tabId
        })
      }
    })
  }
}
