import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post"
export default class extends Controller {
  clearInput() {
    const input = document.getElementById("post_body")
    input.value = ""
    disableButton()
  }
}