import { Controller } from '@hotwired/stimulus';
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from '@fullcalendar/list';
import timeGridPlugin from '@fullcalendar/timegrid';
import resourceTimelinePlugin from '@fullcalendar/resource-timeline';
import '../../assets/stylesheets/calendars/index.css';

export default class extends Controller {
  static targets = ['calendar'];

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
  async fetchEvents(start, end) {
    const response = await fetch(`/calendars/get_jobs.json?start=${start}&end=${end}`);
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
      resourceId: job.resource ? job.resource.id : null,
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
      const currentDate = this.calendar.getDate();
      const oneMonthFromNow = new Date(currentDate.getTime());
      oneMonthFromNow.setMonth(oneMonthFromNow.getMonth() + 1);
      const end = oneMonthFromNow.toISOString();

      this.fetchEvents(currentDate, end).then(({ events, resources }) => {
        this.calendar.setOption('events', events);
        this.calendar.setOption('resources', resources);
        this.calendar.render();
      });
    });
  }

  renderInitialLoad() {
    const currentDate = new Date();
    const oneMonthFromNow = new Date(currentDate.getTime());
    oneMonthFromNow.setMonth(oneMonthFromNow.getMonth() + 1);

    const start = currentDate.toISOString();
    const end = oneMonthFromNow.toISOString();

    this.fetchEvents(start, end).then(({ events, resources }) => {
      this.calendar.setOption('events', events);
      this.calendar.setOption('resources', resources);
      this.calendar.render();
    });
  }
}
