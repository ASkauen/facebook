import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="avatar"
export default class extends Controller {
  Submit() {
    document.getElementById("avatar-form").submit()
  }
}
