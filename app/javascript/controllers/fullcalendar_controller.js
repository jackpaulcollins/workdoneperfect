import { Controller } from '@hotwired/stimulus';
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from '@fullcalendar/list';
import timeGridPlugin from '@fullcalendar/timegrid';
import resourceTimelinePlugin from '@fullcalendar/resource-timeline';

export default class extends Controller {
  static targets = ['calendar'];

  static MONTHS = {
    Jan: 0,
    Feb: 1,
    Mar: 2,
    Apr: 3,
    May: 4,
    Jun: 5,
    Jul: 6,
    Aug: 7,
    Sep: 8,
    Oct: 9,
    Nov: 10,
    Dec: 11,
  };

  connect() {
    this.calendar = new Calendar(this.element, {
      plugins: [dayGridPlugin, listPlugin, timeGridPlugin, resourceTimelinePlugin],
      schedulerLicenseKey: 'XXX',
      headerToolbar: {
        left: 'today prev,next',
        center: 'title',
        right: 'resourceTimelineDay,timeGridWeek,dayGridMonth,listWeek',
      },
      initialView: 'resourceTimelineDay',
      views: {
        resourceTimelineThreeDays: {
          type: 'resourceTimeline',
          duration: { days: 3 },
          buttonText: '3 day',
        },
      },
      resourceAreaHeaderContent: 'Trucks',
    });
    this.subscribeToDateChange();
    // Not guranteed the setDates event fires on first render, so just in case
    this.renderInitialLoad();
  }

  // eslint-disable-next-line class-methods-use-this
  async fetchEvents(startDate, endDate) {
    const response = await fetch(`/calendars/get_jobs.json?start_date=${startDate}&end_date=${endDate}`);
    const data = await response.json();
    const resources = data.reduce((acc, job) => {
      if (job.resource.id > 0) {
        acc.push({ id: job.resource.id, title: job.resource.name });
      } else {
        acc.push({ id: job.resource.id, title: 'Uncategorized' });
      }
      return acc;
    }, []);
    const events = data.map((job) => ({
      id: job.id,
      resourceId: job.resource.id,
      title: job.title,
      start: job.start,
      end: job.end,
      url: `/jobs/${job.id}`,
    }));
    return { events, resources };
  }

  disconnect() {
    this.calendar.destroy();
  }

  subscribeToDateChange() {
    this.calendar.on('datesSet', () => {
      const dateString = this.calendar.currentData.viewTitle;
      const dates = this.parseDate(dateString);

      if (dates) {
        const startDate = dates[0];
        const endDate = dates[1];

        this.fetchEvents(startDate, endDate).then(({ events, resources }) => {
          this.calendar.setOption('events', events);
          this.calendar.setOption('resources', resources);
          this.calendar.render();
        });
      }
    });
  }

  renderInitialLoad() {
    const startDate = new Date();

    this.fetchEvents(startDate, startDate).then(({ events, resources }) => {
      this.calendar.setOption('events', events);
      this.calendar.setOption('resources', resources);
      this.calendar.render();
    });
  }

  parseDate(string) {
    // week view
    if (string.includes('–')) {
      const parsedString = this.parseMultiDayString(string);
      return parsedString;
    }

    // month view
    const dateSchema = string.split(' ');
    const month = dateSchema[0];
    const year = dateSchema[1];

    const startDate = new Date(
      parseInt(year, 10),
      this.constructor.MONTHS[month.substring(0, 3)],
      parseInt(1, 10),
    );

    const endDate = new Date(startDate.getFullYear(), startDate.getMonth() + 1, 0);

    return [startDate, endDate];
  }

  parseMultiDayString(string) {
    const [startStr, endStr] = string.split(' – ');

    if (endStr.length > 10) {
      return this.parseMonthStraddleString(startStr, endStr);
    }
    const [month, startDay] = startStr.split(' ');
    const [endDay, year] = endStr.replace(',', '').split(' ');

    const startDate = new Date(
      parseInt(year, 10),
      this.constructor.MONTHS[month],
      parseInt(startDay, 10),
    );

    const endDate = new Date(
      parseInt(year, 10),
      this.constructor.MONTHS[month],
      parseInt(endDay, 10),
    );

    return [startDate, endDate];
  }

  parseMonthStraddleString(startString, endString) {
    const [month, startDay] = startString.split(' ');
    const [endMonth, endDay, year] = endString.replace(',', '').split(' ');

    const startDate = new Date(
      parseInt(year, 10),
      this.constructor.MONTHS[month],
      parseInt(startDay, 10),
    );

    const endDate = new Date(
      parseInt(year, 10),
      this.constructor.MONTHS[endMonth],
      parseInt(endDay, 10),
    );

    return [startDate, endDate];
  }
}
