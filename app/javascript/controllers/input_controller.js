import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="input"
export default class extends Controller {
    static targets = ["input", "file"]

    connect() {
        this.inputTarget.addEventListener("input", OnInput, false);
    }

    clear() {
        this.inputTarget.value = ""
        this.inputTarget.style.height = "auto"
        this.replaceFileInput()
        this.showFilename()
    }
    
    showFilename() {
        let file = this.fileTarget.files[0]
        let fileName = document.getElementById("file-name")
        let fileNameX = document.getElementById("file")
        if(file != undefined){
            fileName.textContent = file.name
            fileNameX.classList.remove("hidden")
        }else {
            fileName.textContent = ""
            fileNameX.classList.add("hidden")
        }
    }

    replaceFileInput() {
        let fileInput = this.fileTarget;
        let newInput = document.createElement("input")
        newInput.classList.add("hidden")
        newInput.setAttribute("id", "post_image")
        newInput.setAttribute("type", "file")
        newInput.setAttribute("accept", "image/png, image/gif, image/jpeg")
        newInput.setAttribute("name", "post[image]")
        newInput.setAttribute("data-action", "change->input#showFilename")
        newInput.setAttribute("data-input-target", "file")
        fileInput.parentNode.replaceChild(newInput, fileInput)
        this.showFilename()
    }

}

function OnInput() {
    this.style.height = "auto";
    this.style.height = (this.scrollHeight) + "px";
}