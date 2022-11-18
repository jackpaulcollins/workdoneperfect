import { Controller } from "@hotwired/stimulus"
import Choices from 'choices.js'

export default class extends Controller {
  static targets = ['select', 'options']
  initialize () {
    new Choices(this.element,
      {
        allowHTML: true,
        removeItemButton: true,
        classNames: {
          inputCloned: 'choices__input--cloned focus:shadow-none border-none',
        }
      }
    );
  }
}