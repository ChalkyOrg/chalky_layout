import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

// Connects to data-controller="tom-select"
export default class extends Controller {
  static values = {
    multiple: { type: Boolean, default: false }
  }

  connect() {
    this.initTomSelect()
  }

  disconnect() {
    if (this.tomSelect) {
      this.tomSelect.destroy()
      this.tomSelect = null
    }
  }

  initTomSelect() {
    const isMultiple = this.multipleValue || this.element.hasAttribute("multiple")

    // Get placeholder from first empty option or data attribute
    const emptyOption = this.element.querySelector("option[value='']")
    const placeholder = this.element.dataset.placeholder ||
                        (emptyOption && emptyOption.textContent) ||
                        "Select..."

    // Store current value before init
    const currentValue = this.element.value

    // Remove the empty/placeholder option completely
    if (emptyOption) {
      emptyOption.remove()
    }

    const options = {
      plugins: isMultiple ? ["remove_button"] : [],
      allowEmptyOption: false,
      placeholder: placeholder,
      render: {
        no_results: () => {
          return `<div class="chalky-tom-no-results">No results found</div>`
        }
      }
    }

    this.tomSelect = new TomSelect(this.element, options)

    // Clear selection if original was empty (show placeholder)
    if (!currentValue) {
      this.tomSelect.clear()
    }
  }
}
