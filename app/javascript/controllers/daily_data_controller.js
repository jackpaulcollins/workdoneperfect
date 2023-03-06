import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="daily-data"
export default class extends Controller {
  connect() {
    console.log("hi")
  }
}
