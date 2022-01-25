import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  connect() {
    let userId = document.querySelector('meta[name="user-id"]').content
    let notifsBox = document.getElementById(`notifs-box${userId}`)
    let notifs = document.getElementById("notifs")
    window.addEventListener("click", function(e) {
      if(!getParents(e.target).includes(notifs) && (e.target).nodeName != "INPUT"){
        hideNotifications(notifsBox)
      }
    })
  }

  toggle() {
    let userId = document.querySelector('meta[name="user-id"]').content
    let notifsBox = document.getElementById(`notifs-box${userId}`)
    if(Array.from(notifsBox.classList).includes("hidden")){
      showNotifications(notifsBox)
    }else{
      hideNotifications(notifsBox)
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