// Grid Responsive Controller
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["table", "cards", "column"]
  static values = {
    mode: String, // "table", "cards", "auto"
    breakpoint: Number
  }

  connect() {
    this.modeValue = this.modeValue || "auto"
    this.breakpointValue = this.breakpointValue || 1024 // lg breakpoint

    if (this.modeValue === "auto") {
      this.handleResize()
      window.addEventListener("resize", this.handleResize.bind(this))
    }

    this.restoreColumnPreferences()
  }

  disconnect() {
    if (this.modeValue === "auto") {
      window.removeEventListener("resize", this.handleResize.bind(this))
    }
  }

  // Handle responsive breakpoints
  handleResize() {
    const isDesktop = window.innerWidth >= this.breakpointValue

    if (isDesktop) {
      this.showTable()
    } else {
      this.showCards()
    }
  }

  showTable() {
    if (this.hasTableTarget) {
      this.tableTarget.classList.remove("hidden")
    }
    if (this.hasCardsTarget) {
      this.cardsTarget.classList.add("hidden")
    }
  }

  showCards() {
    if (this.hasTableTarget) {
      this.tableTarget.classList.add("hidden")
    }
    if (this.hasCardsTarget) {
      this.cardsTarget.classList.remove("hidden")
    }
  }

  // Column visibility controls
  toggleColumn(event) {
    const checkbox = event.target
    const columnName = checkbox.dataset.column
    const isVisible = checkbox.checked

    this.setColumnVisibility(columnName, isVisible)
    this.saveColumnPreferences()
  }

  setColumnVisibility(columnName, visible) {
    const columns = this.element.querySelectorAll(`[data-column="${columnName}"]`)

    columns.forEach(column => {
      if (visible) {
        column.classList.remove("hidden")
        column.classList.add("table-cell")
      } else {
        column.classList.add("hidden")
        column.classList.remove("table-cell")
      }
    })
  }

  showAll() {
    const checkboxes = this.element.querySelectorAll('input[type="checkbox"][data-column]')

    checkboxes.forEach(checkbox => {
      checkbox.checked = true
      this.setColumnVisibility(checkbox.dataset.column, true)
    })

    this.saveColumnPreferences()
  }

  hideOptional() {
    const checkboxes = this.element.querySelectorAll('input[type="checkbox"][data-column]')

    checkboxes.forEach(checkbox => {
      const columnName = checkbox.dataset.column
      const columnElements = this.element.querySelectorAll(`[data-column="${columnName}"]`)
      let isOptional = false

      columnElements.forEach(element => {
        if (element.dataset.priority === "optional") {
          isOptional = true
        }
      })

      if (isOptional) {
        checkbox.checked = false
        this.setColumnVisibility(columnName, false)
      }
    })

    this.saveColumnPreferences()
  }

  // Persistence
  saveColumnPreferences() {
    const preferences = {}
    const checkboxes = this.element.querySelectorAll('input[type="checkbox"][data-column]')

    checkboxes.forEach(checkbox => {
      preferences[checkbox.dataset.column] = checkbox.checked
    })

    const storageKey = this.getStorageKey()
    localStorage.setItem(storageKey, JSON.stringify(preferences))
  }

  restoreColumnPreferences() {
    const storageKey = this.getStorageKey()
    const saved = localStorage.getItem(storageKey)

    // Show all columns by default
    const checkboxes = this.element.querySelectorAll('input[type="checkbox"][data-column]')
    checkboxes.forEach(checkbox => {
      checkbox.checked = true
      this.setColumnVisibility(checkbox.dataset.column, true)
    })

    if (!saved) return

    try {
      const preferences = JSON.parse(saved)

      Object.entries(preferences).forEach(([columnName, visible]) => {
        const checkbox = this.element.querySelector(`input[data-column="${columnName}"]`)
        if (checkbox) {
          checkbox.checked = visible
          this.setColumnVisibility(columnName, visible)
        }
      })
    } catch (e) {
      console.warn("Could not restore column preferences:", e)
    }
  }

  getStorageKey() {
    const gridId = this.element.id || this.element.dataset.gridId || "default"
    return `grid-columns-${gridId}`
  }

  // Manual mode switching (for testing/debugging)
  switchToTable() {
    this.modeValue = "table"
    this.showTable()
  }

  switchToCards() {
    this.modeValue = "cards"
    this.showCards()
  }

  switchToAuto() {
    this.modeValue = "auto"
    this.handleResize()
  }
}
