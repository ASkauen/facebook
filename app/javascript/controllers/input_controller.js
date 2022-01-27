import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="input"
export default class extends Controller {
    static targets = ["input"]

    connect() {
        this.inputTarget.addEventListener("input", OnInput, false);
    }

    clear() {
        this.inputTarget.value = ""
        this.style.height = "auto";
    }
}

function OnInput() {
    this.style.height = "auto";
    this.style.height = (this.scrollHeight) + "px";
}
