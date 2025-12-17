import { Controller } from "@hotwired/stimulus"

// Utility controller to stop event propagation
// Used in dropdowns inside collapsible sections
export default class extends Controller {
  stop(event) {
    event.stopPropagation()
  }
}
