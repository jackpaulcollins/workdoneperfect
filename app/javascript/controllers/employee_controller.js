import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="exployee"
export default class extends Controller {
  connect() {
  }

  select(e) {
    let element = document.getElementById("employee-form");
    
    Rails.ajax({
      url: "/employees/set-template",
      type: "post",
      data: `template_id=${e.target.value}`,
      success: function(data) {
        if (data.status == 200) {
          element.classList.remove("hidden");
        }
      },
      error: function(data) {}
    })
  }
}
