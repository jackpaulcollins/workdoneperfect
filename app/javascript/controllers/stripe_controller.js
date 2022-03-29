import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "paymentElement", "error", "form" ]
  static values = {
    clientSecret: String,
    returnUrl: String
  }

  connect() {
    this.stripe = Stripe(this.stripeKey)
    this.elements = this.stripe.elements({
      appearance: {
        theme: "stripe",
      },
      clientSecret: this.clientSecretValue
    })

    this.paymentElement = this.elements.create("payment")
    this.paymentElement.mount(this.paymentElementTarget)
  }

  changed(event) {
    if (event.error) {
      this.errorTarget.textContent = event.error.message
    } else {
      this.errorTarget.textContent = ""
    }
  }

  async submit(event) {
    event.preventDefault()
    Rails.disableElement(this.formTarget)

    // Payment Intents
    if (this.clientSecretValue.startsWith("pi_")) {
      const { error } = await this.stripe.confirmPayment({
        elements: this.elements,
        confirmParams: {
          return_url: this.returnUrlValue,
        },
      });
      this.showError(error)

    // Setup Intents
    } else {
      const { error } = await this.stripe.confirmSetup({
        elements: this.elements,
        confirmParams: {
          return_url: this.returnUrlValue,
        },
      });
      this.showError(error)
    }
  }

  showError(error) {
    let message

    if (error.type === "card_error" || error.type === "validation_error") {
      message = error.message
    } else {
      message = "An unexpected error occured."
    }

    this.errorTarget.textContent = message
    setTimeout(() => {
      Rails.enableElement(this.formTarget)
    }, 100)
  }

  get stripeKey() {
    return document.querySelector('meta[name="stripe-key"]').getAttribute("content")
  }
}
