import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="job-template-form"
export default class extends Controller {
  static targets = ['target', 'template']
  static values = {
    wrapperSelector: {
      type: String,
      default: '.job-template-form-wrapper'
    }
  }

  add (e) {
    e.preventDefault()

    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString())
    this.targetTarget.insertAdjacentHTML('beforebegin', content)
  }

  remove (e) {
    e.preventDefault()

    const wrapper = e.target.closest(this.wrapperSelectorValue)

    if (wrapper.dataset.newRecord === 'true') {
      wrapper.remove()
    } else {
      e.target.parentNode.parentNode.parentNode.style.display = 'none';

      const input = wrapper.querySelector("input[name*='_destroy']")

      input.value = '1'
    }
  }
}
