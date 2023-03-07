import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static outlets = ['fullcalendar'];

  static targets = ['dateDisplay'];

  connect() {
    this.fullcalendarOutlet.calendar.on('datesSet', () => {
      const dateString = this.fullcalendarOutlet.calendar.currentData.viewTitle;
      const dateObj = new Date(dateString);
      const month = dateObj.toLocaleString('default', { month: 'long' });
      const day = dateObj.getDate();
      const ordinal = this.getOrdinal(day);
      const dayStr = `${day}${ordinal}'s`;
      const formattedDate = `${month} ${dayStr} revenue`;
      this.dateDisplayTarget.innerHTML = formattedDate;
      this.fetchData(dateString);
    });
  }

  // eslint-disable-next-line class-methods-use-this
  async fetchData(dateString) {
    const response = await fetch(`/dashboard/daily_data.json?dates=${dateString}`);
    const data = await response.json();
    console.log(data);
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
