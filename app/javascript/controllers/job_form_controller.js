// Connects to data-controller="job-form"

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["totalHoursField", "revenueField", "totalHoursHiddenField", "revenueHiddenField"];

  connect() {
    this.element.addEventListener("submit", this.submitHandler.bind(this));
  }

  submitHandler() {
    if (this.totalHoursFieldTarget.value) {
      this.totalHoursHiddenFieldTarget.value = this.totalHoursFieldTarget.value;
    }

    if (this.revenueFieldTarget.value) {
      this.revenueHiddenFieldTarget.value = this.revenueFieldTarget.value;
    }
  }
}
