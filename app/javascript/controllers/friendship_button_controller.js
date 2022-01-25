import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="friendship-button"
export default class extends Controller {
  refresh() {
    location.reload()
  }
}
