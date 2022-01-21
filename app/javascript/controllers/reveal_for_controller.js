import { Controller } from "@hotwired/stimulus"

// reveals certain dom element only if they match the user it in the meta tag, to use:
// your html, need a user id:
// <meta name="user-id" content="123">
//
// in the html, you can then do this:

// <button data-controller="reveal-for" data-reveal-for-id-value="123">

// could be extended to use targets instead and reveal / hide all those targets


export default class extends Controller {
    static values = {
        id: String
    }

    connect() {
        if (this.userId != this.idValue) {
            this.element.classList.add("hidden")
        } else {
            this.element.classList.remove("hidden")
        }
    }

    get userId() {
        if (document.querySelector('meta[name="user-id"]')) {
            return document.querySelector('meta[name="user-id"]').content
        } else {
            return ""
        }
    }
}