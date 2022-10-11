import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="employee-template"
export default class extends Controller {
  static targets = ["attributes"]

  connect() {
    const template = (this.data.get("template"))

    const parsedTemplate = template.replace("[","").replace("]","").replaceAll('"',"").split(",")
    const array = Array.from(parsedTemplate)

    const html = array.map((a) => {
        return `<div><input multiple="multiple" class="form-control" type="text" required=true name="employee_template[template_attributes][]" id="employee_template_template_attributes" value="${a}"></input></div>`
      })

      console.log(html)

    html.forEach(h => this.attributesTarget.innerHTML += h.toString())

  }
}
