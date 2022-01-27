import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-more"
export default class extends Controller {
  static values = {
    height: String,
    id: String
  }

  expandDiv(){
    let divToExpand = document.getElementById(`expandable${this.idValue}`)
    let showMoreButton = document.getElementById(`show-more-button${this.idValue}`)
    divToExpand.classList.toggle(this.heightValue)
    this.element.classList.toggle("shadow-blur-over")
    if(showMoreButton.textContent.trim() == "Show more..."){
      showMoreButton.textContent = "Show less..."
    }else{
      showMoreButton.textContent = "Show more..."
    }
  }
}
