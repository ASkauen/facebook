import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-more"
export default class extends Controller {
  toggleLikers(){
    let likers = document.getElementById("likers")
    let likersButton = document.getElementById("likers-button")
    likers.classList.toggle("h-10")
    this.element.classList.toggle("shadow-blur-over")
    if(likersButton.textContent.trim() == "Show more..."){
      likersButton.textContent = "Show less..."
    }else{
      likersButton.textContent = "Show more..."
    }
  }
}
