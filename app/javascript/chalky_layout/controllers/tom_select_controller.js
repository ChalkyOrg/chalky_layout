import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

// Connects to data-controller="tom-select"
export default class extends Controller {
  static values = {
    multiple: { type: Boolean, default: false },
    url: String,
    minChars: { type: Number, default: 2 },
    preload: { type: Boolean, default: false }
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
          return `<div class="chalky-tom-no-results">Aucun résultat</div>`
        },
        loading: () => {
          return `<div class="chalky-tom-loading">Recherche...</div>`
        }
      }
    }

    // AJAX mode if URL is provided
    if (this.hasUrlValue) {
      Object.assign(options, {
        valueField: "value",
        labelField: "text",
        searchField: ["text"],
        loadThrottle: 300,
        preload: this.preloadValue,
        shouldLoad: (query) => {
          return query.length >= this.minCharsValue
        },
        load: (query, callback) => {
          const url = new URL(this.urlValue, window.location.origin)
          url.searchParams.set("q", query)

          fetch(url)
            .then(response => response.json())
            .then(json => callback(json))
            .catch(() => callback())
        },
        onItemAdd: () => {
          // Clear the search input after selecting an item
          this.tomSelect.setTextboxValue("")
          this.tomSelect.refreshOptions(false)
        }
      })
    }

    this.tomSelect = new TomSelect(this.element, options)

    // Clear selection if original was empty (show placeholder)
    if (!currentValue) {
      this.tomSelect.clear()
    }
  }
}
