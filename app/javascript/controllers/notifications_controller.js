import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  connect() {
    let notifs = document.getElementById("notifications")
    let bell = document.getElementById("bell")
    window.addEventListener("click", function(e) {
      console.log(getParents(e.target))
      if(!getParents(e.target).includes(notifs) && e.target != bell){
        hideNotifications(notifs)
      }
    })
  }

  toggle() {
    let notifs = document.getElementById("notifications")
    if(Array.from(notifs.classList).includes("hidden")){
      showNotifications(notifs)
    }else{
      hideNotifications(notifs)
    }
  }
}

function getParents(element, parents = []) {
  if(element == null){return parents}
  parents.push(element)
  let parent = element.parentElement
  return getParents(parent, parents)
}

function showNotifications(notifs) {
  notifs.classList.remove("hidden")
}

function hideNotifications(notifs){
  notifs.classList.add("hidden")
}