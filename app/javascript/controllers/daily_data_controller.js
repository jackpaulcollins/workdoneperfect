import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static outlets = ['fullcalendar'];

  static targets = ['dateDisplay', 'dollarDisplay'];

  connect() {
    this.fullcalendarOutlet.calendar.on('datesSet', () => {
      const displayDate = this.fullcalendarOutlet.calendar.currentData.viewTitle;

      console.log(displayDate)
      this.dateDisplayTarget.innerHTML = this.formatDate(displayDate);
      this.fetchData(displayDate);
    });
  }

  // eslint-disable-next-line class-methods-use-this
  async fetchData(dateString) {
    const response = await fetch(`/dashboard/daily_data.json?dates=${dateString}`);
    const data = await response.json();
    this.dollarDisplayTarget.innerHTML = `$ ${data.projected_revenue}`;
  }

  formatDate(date) {
    const dateObj = new Date(date);
    const month = dateObj.toLocaleString('default', { month: 'long' });
    const day = dateObj.getDate();
    const ordinal = this.getOrdinal(day);
    const dayStr = `${day}${ordinal}`;
    return `${month} ${dayStr}`;
  }

  // eslint-disable-next-line class-methods-use-this
  getOrdinal(day) {
    const ones = day % 10;
    const tens = Math.floor(day / 10) % 10;
    if (tens === 1) {
      return 'th';
    } if (ones === 1) {
      return 'st';
    } if (ones === 2) {
      return 'nd';
    } if (ones === 3) {
      return 'rd';
    }
    return 'th';
  }
}
