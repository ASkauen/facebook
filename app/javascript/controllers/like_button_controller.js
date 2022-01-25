import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="like-button"
export default class extends Controller {
    static values = {
        post: Number,
        likers: Array
    }

    connect() {
        this.likeButton = document.getElementById(`like${this.postValue}`)
        this.unlikeButton = document.getElementById(`unlike${this.postValue}`)
        if(this.likersValue.includes(parseInt(this.userId))){
            this.unlikeButton.classList.remove("hidden")
        }else {
            this.likeButton.classList.remove("hidden")
        }
    }

    toggle() {
        this.likeButton.classList.toggle("hidden")
        this.unlikeButton.classList.toggle("hidden")
    }

    get userId() {
        if (document.querySelector('meta[name="user-id"]')) {
            return document.querySelector('meta[name="user-id"]').content
        } else {
            return ""
        }
    }
}
