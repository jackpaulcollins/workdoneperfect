import { Controller } from '@hotwired/stimulus';
import DateParser from 'fullcalendar_dateparser';

export default class extends Controller {
  static outlets = ['fullcalendar'];

  static targets = ['dateDisplay', 'dollarDisplay', 'jobCountDisplay', 'capturedRevenueDisplay'];

  connect() {
    this.fullcalendarOutlet.calendar.on('datesSet', () => {
      const displayDate = this.fullcalendarOutlet.calendar.currentData.viewTitle;
      this.dateDisplayTarget.innerHTML = displayDate;
      const [startDate, endDate] = DateParser.parse(displayDate);
      this.fetchData(startDate, endDate);
    });
  }

  // eslint-disable-next-line class-methods-use-this
  async fetchData(start, end) {
    const response = await fetch(`/dashboard/daily_data.json?start=${start}&end=${end}}`);
    const data = await response.json();
    this.dollarDisplayTarget.innerHTML = `$ ${data.projected_revenue}`;
    this.jobCountDisplayTarget.innerHTML = `${data.job_count}`;
    this.capturedRevenueDisplayTarget.innerHTML = `$ ${data.captured_revenue}`;
  }
}
