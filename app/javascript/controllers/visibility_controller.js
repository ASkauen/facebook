import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="visibility"
export default class extends Controller {
  static targets = [ "toggle" ]

  toggle() {
    this.toggleTargets.forEach(t => t.classList.toggle("hidden"))
  }
}
