import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="friendship-button"
export default class extends Controller {
  static targets = [ "add", "remove", "sent", "cancel", "respond", "accepted"]

  showAdd() {
    this.addTarget.classList.remove("hidden")
    this.removeTarget.classList.add("hidden")
    this.cancelTarget.classList.add("hidden")
    this.respondTarget.classList.add("hidden")
  }

  showAccepted() {
    this.respondTarget.classList.add("hidden")
    this.acceptedTarget.classList.remove("hidden")
  }
  
  showSent() {
    this.addTarget.classList.add("hidden")
    this.sentTarget.classList.remove("hidden")
  }
}
