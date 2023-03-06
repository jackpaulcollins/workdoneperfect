import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static outlets = ['fullcalendar'];

  connect() {
    this.fullcalendarOutlet.calendar.on('datesSet', () => {
      const dateString = this.fullcalendarOutlet.calendar.currentData.viewTitle;
      this.fetchData(dateString);
    });
  }

  // eslint-disable-next-line class-methods-use-this
  async fetchData(dateString) {
    const response = await fetch(`/dashboard/daily_data.json?dates=${dateString}`);
    const data = await response.json();
    console.log(data);
  }
}
